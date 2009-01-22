require 'osx/cocoa'

class HeadsUpApplication < OSX::NSObject
  attr_reader :app_path

  kvc_accessor :button_enabled, :button_title

  def initWithAppPath(app_path)
    init
    @app_path = app_path
    OSX::NSDistributedNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :refresh, 'HeadsUpLaunched', 'org.matthewtodd.HeadsUp')
    OSX::NSDistributedNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :refresh, 'HeadsUpQuitOkay', 'org.matthewtodd.HeadsUp')
    self
  end

  def refresh(*args)
    self.button_title = is_running ? 'Stop HeadsUp' : 'Start HeadsUp'
    self.button_enabled = true

    willChangeValueForKey(:start_at_login)
    OSX::CFPreferencesAppSynchronize('loginwindow')
    didChangeValueForKey(:start_at_login)
  end

  def start_at_login
    login_items = OSX::CFPreferencesCopyAppValue('AutoLaunchedApplicationDictionary', 'loginwindow')
    login_items.any? { |item| item['Path'] == app_path }
  end

  def start_at_login=(start_at_login)
    willChangeValueForKey(:start_at_login)

    if start_at_login.to_ruby
      login_items = OSX::CFPreferencesCopyAppValue('AutoLaunchedApplicationDictionary', 'loginwindow').autorelease.mutableCopy
      login_items << { 'Path' => app_path } unless login_items.any? { |item| item['Path'] == app_path }
      OSX::CFPreferencesSetAppValue('AutoLaunchedApplicationDictionary', login_items, 'loginwindow')
      OSX::CFPreferencesAppSynchronize('loginwindow')
    else
      login_items = OSX::CFPreferencesCopyAppValue('AutoLaunchedApplicationDictionary', 'loginwindow').autorelease.mutableCopy
      login_items.reject! { |item| item['Path'] == app_path }
      OSX::CFPreferencesSetAppValue('AutoLaunchedApplicationDictionary', login_items, 'loginwindow')
      OSX::CFPreferencesAppSynchronize('loginwindow')
    end

    didChangeValueForKey(:start_at_login)
    start_at_login
  end

  def start_stop
    is_running ? stop : start
  end

  private

  def executable_path
    app_path.stringByAppendingPathComponent('Contents').stringByAppendingPathComponent('MacOS').stringByAppendingPathComponent('HeadsUp')
  end

  def is_running
    `ps axww`.grep(/#{executable_path}/).any?
  end

  def stop
    self.button_enabled = false
    OSX::NSDistributedNotificationCenter.defaultCenter.postNotificationName_object_userInfo_deliverImmediately('HeadsUpQuit', 'org.matthewtodd.HeadsUp', nil, true)
    performSelector_withObject_afterDelay('refresh', nil, 4.0)
  end

  def start
    self.button_enabled = false
    OSX::NSTask.launchedTaskWithLaunchPath_arguments(executable_path, [])
    performSelector_withObject_afterDelay('refresh', nil, 4.0)
  end
end

class HeadsUpPreferences < OSX::NSObject
  attr_reader :identifier

  def initWithBundleIdentifier(identifier)
    @identifier = identifier
    self
  end

  def valueForKey(key)
    OSX::CFPreferencesCopyAppValue(key, identifier)
  end

  def setValue_forKey(value, key)
    willChangeValueForKey(key)
    OSX::CFPreferencesSetAppValue(key, value, identifier)
    OSX::CFPreferencesAppSynchronize(identifier)
    OSX::NSDistributedNotificationCenter.defaultCenter.postNotificationName_object('HeadsUpPreferencesChanged', identifier)
    didChangeValueForKey(key)
    value
  end

  def refresh
    all_preference_keys.each { |key| willChangeValueForKey(key) }
    OSX::CFPreferencesAppSynchronize(identifier)
    all_preference_keys.each { |key| didChangeValueForKey(key) }
  end

  private

  def all_preference_keys
    OSX::CFPreferencesCopyKeyList(identifier, OSX::KCFPreferencesCurrentUser, OSX::KCFPreferencesAnyHost)
  end
end

class HeadsUpPreferencePane < OSX::NSPreferencePane
  attr_accessor :application, :preferences

  def initWithBundle(bundle)
    super_initWithBundle(bundle)
    self.application = HeadsUpApplication.alloc.initWithAppPath(bundle.pathForResource_ofType('HeadsUp', 'app'))
    self.preferences = HeadsUpPreferences.alloc.initWithBundleIdentifier(bundle.bundleIdentifier)
    self
  end

  def willSelect
    application.refresh
    preferences.refresh
  end
end
