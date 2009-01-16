require 'osx/cocoa'

class HeadsUpWindowController < OSX::NSWindowController
  def initWithLocation_command(location, command)
    initWithWindow(HeadsUpWindow.alloc.initWithLocation(location))
  end
end