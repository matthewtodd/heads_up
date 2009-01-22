require 'osx/cocoa'

class HeadsUp < OSX::NSObject
  def applicationDidFinishLaunching(aNotification)
    @controllers = [:bottom_left, :bottom_right].map { |location| HeadsUpWindowController.alloc.initWithLocation(location) }

    OSX::NSNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :applicationDidChangeScreenParameters, 'NSApplicationDidChangeScreenParametersNotification', nil)

    distributed_notifications.addObserver_selector_name_object(self, :preferencesChanged, 'HeadsUpPreferencesChanged', 'org.matthewtodd.HeadsUp')
    distributed_notifications.addObserver_selector_name_object(self, :quit, 'HeadsUpQuit', 'org.matthewtodd.HeadsUp')
    distributed_notifications.postNotificationName_object_userInfo_deliverImmediately('HeadsUpLaunched', 'org.matthewtodd.HeadsUp', nil, false)
  end

  def applicationDidChangeScreenParameters(aNotification)
    @controllers.each { |controller| controller.update_window_position }
  end

  def preferencesChanged(aNotification)
    @controllers.each { |controller| controller.update_preferences }
  end

  def quit(aNotification)
    distributed_notifications.postNotificationName_object_userInfo_deliverImmediately('HeadsUpQuitOkay', 'org.matthewtodd.HeadsUp', nil, false)
    OSX::NSApplication.sharedApplication.terminate(self)
  end

  private

  def distributed_notifications
    @distributed_notifications ||= OSX::NSDistributedNotificationCenter.defaultCenter
  end
end