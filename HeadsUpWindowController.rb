require 'osx/cocoa'

class HeadsUpWindowController < OSX::NSWindowController
  def initWithLocation_command(location, command)
    @command = command
    initWithWindow(HeadsUpWindow.alloc.initWithLocation(location))
    start_window_update_timer
    self
  end

  def update_window_contents
    window.updateContents(`#{@command}`)
  end

  def update_window_position
    window.updatePosition
  end

  private

  def start_window_update_timer
    timer = OSX::NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(60, self, :update_window_contents, nil, true)
    timer.fire
  end
end