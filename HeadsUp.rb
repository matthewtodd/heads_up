require 'osx/cocoa'

class HeadsUp < OSX::NSObject
  def applicationDidFinishLaunching(aNotification)
    @controllers = []
    @controllers << HeadsUpWindowController.alloc.initWithLocation_command(:bottom_left, '/Users/mtodd/Code/events/bin/events')
    @controllers << HeadsUpWindowController.alloc.initWithLocation_command(:bottom_right, '/opt/local/bin/downloads status')
  end
end