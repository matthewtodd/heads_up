require 'osx/cocoa'

class HeadsUp < OSX::NSObject
  def applicationDidFinishLaunching(aNotification)
    @controller = HeadsUpWindowController.alloc.init
  end
end