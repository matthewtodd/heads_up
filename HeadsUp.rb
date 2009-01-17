require 'osx/cocoa'

class HeadsUp < OSX::NSObject
  def applicationDidChangeScreenParameters(aNotification)
    @controllers.each { |controller| controller.update_window_position }
  end

  def applicationDidFinishLaunching(aNotification)
    OSX::NSNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :applicationDidChangeScreenParameters, 'NSApplicationDidChangeScreenParametersNotification', nil)

    @controllers = []
    @controllers << HeadsUpWindowController.alloc.initWithLocation_command(:bottom_left, '/Users/mtodd/Code/Inactive/events/bin/events 2009-03-29')
    @controllers << HeadsUpWindowController.alloc.initWithLocation_command(:bottom_right, '/bin/date')
  end
end