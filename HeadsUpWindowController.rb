require 'osx/cocoa'

class HeadsUpWindowController < OSX::NSWindowController
  def initWithLocation_command(location, command)
    initWithWindow(HeadsUpWindow.alloc.initWithLocation(location))
    @command = command
    start_window_update_timer
  end

  def update_window_contents
    window.update_contents(`#{@command}`)
  end

  private

  def start_window_update_timer
    timer = OSX::NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(60, self, :update_window_contents, nil, true)
    timer.fire
  end
end