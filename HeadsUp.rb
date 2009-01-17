require 'osx/cocoa'

class HeadsUp < OSX::NSObject
  def applicationDidFinishLaunching(aNotification)
    @controllers = []
    @controllers << HeadsUpWindowController.alloc.initWithLocation_command(:bottom_left, '/Users/mtodd/Code/Inactive/events/bin/events 2009-03-29')
    @controllers << HeadsUpWindowController.alloc.initWithLocation_command(:bottom_right, '/bin/date')
  end
end