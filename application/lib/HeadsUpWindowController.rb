require 'osx/cocoa'

class HeadsUpWindowController < OSX::NSWindowController
  attr_reader :command, :location

  def initWithLocation(location)
    initWithWindow(HeadsUpWindow.alloc.initWithLocation(location))
    @location = location
    update_preferences
    self
  end

  def update_preferences
    @command = preferences.stringForKey(location).to_s
    @timer.invalidate if @timer
    @timer = OSX::NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(60, self, :update_window_contents, nil, true)
    @timer.fire
  end

  def update_window_contents
    if command.empty?
      window.updateContents('')
    else
      window.updateContents(`#{@command}`)
    end
  end

  def update_window_position
    window.updatePosition
  end

  private

  def preferences
    defaults = OSX::NSUserDefaults.standardUserDefaults
    defaults.synchronize
    defaults
  end
end