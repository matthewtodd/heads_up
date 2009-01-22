require 'osx/cocoa'

class HeadsUpApplication < OSX::NSObject
  attr_reader :executable_path

  def initWithExecutablePath(executable_path)
    init
    @executable_path = executable_path
    @properties = {}

    OSX::NSDistributedNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :refresh, 'HeadsUpLaunched', 'org.matthewtodd.HeadsUp')
    OSX::NSDistributedNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :refresh, 'HeadsUpQuitOkay', 'org.matthewtodd.HeadsUp')

    self
  end

  def valueForKey(key)
    @properties[key.to_sym]
  end

  def setValue_forKey(value, key)
    willChangeValueForKey(key)
    @properties[key.to_sym] = value
    didChangeValueForKey(key)
    value
  end

  def refresh(*args)
    setValue_forKey(is_running ? 'Stop HeadsUp' : 'Start HeadsUp', 'button_title')
    setValue_forKey(true, 'button_enabled')
  end

  def start_stop
    is_running ? stop : start
  end

  private

  def is_running
    `ps axww`.grep(/#{executable_path}/).any?
  end

  def stop
    setValue_forKey(false, 'button_enabled')
    OSX::NSDistributedNotificationCenter.defaultCenter.postNotificationName_object_userInfo_deliverImmediately('HeadsUpQuit', 'org.matthewtodd.HeadsUp', nil, true)
    performSelector_withObject_afterDelay('refresh', nil, 4.0)
  end

  def start
    setValue_forKey(false, 'button_enabled')
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
    self.application = HeadsUpApplication.alloc.initWithExecutablePath(bundle.pathForResource_ofType('HeadsUp', 'app').stringByAppendingPathComponent('Contents').stringByAppendingPathComponent('MacOS').stringByAppendingPathComponent('HeadsUp'))
    self.preferences = HeadsUpPreferences.alloc.initWithBundleIdentifier(bundle.bundleIdentifier)
    self
  end

  def willSelect
    application.refresh
    preferences.refresh
  end
end
