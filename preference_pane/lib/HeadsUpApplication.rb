require 'osx/cocoa'

class HeadsUpApplication < OSX::NSObject
  attr_reader :app_path

  kvc_accessor :button_enabled, :button_title, :status, :spinner_enabled, :version

  def initWithBundle(bundle)
    init
    @app_path = bundle.pathForResource_ofType('HeadsUp', 'app')
    @version  = bundle.infoDictionary.objectForKey('CFBundleShortVersionString')
    OSX::NSDistributedNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :refresh, 'HeadsUpLaunched', 'org.matthewtodd.HeadsUp')
    OSX::NSDistributedNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :refresh, 'HeadsUpQuitOkay', 'org.matthewtodd.HeadsUp')
    self
  end

  def refresh(*args)
    self.button_title = is_running ? 'Stop HeadsUp' : 'Start HeadsUp'
    self.button_enabled = true
    self.status = is_running ? 'HeadsUp is running.' : 'HeadsUp is stopped.'
    self.spinner_enabled = false
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
    self.status = 'Stopping HeadsUp...'
    self.spinner_enabled = true
    self.start_at_login = false
    OSX::NSDistributedNotificationCenter.defaultCenter.postNotificationName_object_userInfo_deliverImmediately('HeadsUpQuit', 'org.matthewtodd.HeadsUp', nil, true)
    performSelector_withObject_afterDelay('refresh', nil, 4.0)
  end

  def start
    self.button_enabled = false
    self.status = 'Starting HeadsUp...'
    self.spinner_enabled = true
    self.start_at_login = true
    OSX::NSTask.launchedTaskWithLaunchPath_arguments(executable_path, [])
    performSelector_withObject_afterDelay('refresh', nil, 4.0)
  end

  def start_at_login=(start_at_login)
    OSX::CFPreferencesAppSynchronize('loginwindow')
    login_items = OSX::CFPreferencesCopyAppValue('AutoLaunchedApplicationDictionary', 'loginwindow').autorelease.to_ruby
    login_items.reject! { |item| item['Path'] == app_path }
    login_items << { 'Path' => app_path } if start_at_login
    OSX::CFPreferencesSetAppValue('AutoLaunchedApplicationDictionary', login_items, 'loginwindow')
    OSX::CFPreferencesAppSynchronize('loginwindow')
  end
end
