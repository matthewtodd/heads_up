require 'osx/cocoa'

class HeadsUp < OSX::NSObject
  def applicationDidFinishLaunching(aNotification)
    @controllers = [:bottom_left, :bottom_right].map do |location|
      HeadsUpWindowController.alloc.initWithLocation(location)
    end
    OSX::NSNotificationCenter.defaultCenter.addObserver_selector_name_object(self, :applicationDidChangeScreenParameters, 'NSApplicationDidChangeScreenParametersNotification', nil)
  end

  def applicationDidChangeScreenParameters(aNotification)
    @controllers.each { |controller| controller.update_window_position }
  end
end