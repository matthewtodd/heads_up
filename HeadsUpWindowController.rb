require 'osx/cocoa'

class HeadsUpWindowController < OSX::NSWindowController
  def initWithLocation(location)
    @location = location
    initWithWindow(HeadsUpWindow.alloc.initWithLocation(location))
    initialize_user_defaults
    read_command_from_user_defaults
    start_window_update_timer
    self
  end

  def update_window_contents
    window.updateContents(`#{@command}`) unless @command.empty?
  end

  def update_window_position
    window.updatePosition
  end

  private

  def initialize_user_defaults
    @defaults = OSX::NSUserDefaults.standardUserDefaults
    @defaults.registerDefaults(@location => { :command => '' })
  end

  def read_command_from_user_defaults
    @command = @defaults.dictionaryForKey(@location).objectForKey(:command)
  end

  def start_window_update_timer
    timer = OSX::NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats(60, self, :update_window_contents, nil, true)
    timer.fire
  end
end