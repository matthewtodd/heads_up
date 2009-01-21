require 'osx/cocoa'

class HeadsUpWindowController < OSX::NSWindowController
  def initWithLocation(location)
    initWithWindow(HeadsUpWindow.alloc.initWithLocation(location))

    @command = OSX::NSUserDefaults.standardUserDefaults.stringForKey(location)
    @timer = OSX::NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(60, self, :update_window_contents, nil, true)
    @timer.fire

    self
  end

  def update_window_contents
    window.updateContents(`#{@command}`) unless @command.empty?
  end

  def update_window_position
    window.updatePosition
  end
end