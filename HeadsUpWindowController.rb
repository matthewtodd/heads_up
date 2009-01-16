require 'osx/cocoa'

class HeadsUpWindowController < OSX::NSWindowController
  def init
    initWithWindow(HeadsUpWindow.alloc.init)
  end
end