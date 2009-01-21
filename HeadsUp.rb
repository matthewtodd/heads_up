require 'osx/cocoa'

class HeadsUp < OSX::NSObject
  def applicationDidFinishLaunching(aNotification)
    @controllers = [:bottom_left, :bottom_right].map { |location| HeadsUpWindowController.alloc.initWithLocation(location) }
    OSX::NSNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :applicationDidChangeScreenParameters, 'NSApplicationDidChangeScreenParametersNotification', nil)
    OSX::NSDistributedNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :preferencesChanged, 'HeadsUpPreferencesChanged', 'org.matthewtodd.HeadsUp')
  end

  def applicationDidChangeScreenParameters(aNotification)
    @controllers.each { |controller| controller.update_window_position }
  end

  def preferencesChanged(aNotification)
    @controllers.each { |controller| controller.update_preferences }
  end
end