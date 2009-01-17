require 'osx/cocoa'

class HeadsUpWindow < OSX::NSWindow
  ROWS, COLS = 12, 80
  FONT_HEIGHT, FONT_WIDTH = 16.0, 7.201171875 # FIXME chicken-and-egg keeps me from asking layoutManger.defaultLineHeightForFont. So resize window, textView, *after* initializing?

  def initWithLocation(location)
    initWithContentRect_styleMask_backing_defer(frame_for_location(location), OSX::NSBorderlessWindowMask, OSX::NSBackingStoreBuffered, false)

    @location = location

    setAutodisplay(true)
    setBackgroundColor(OSX::NSColor.clearColor)
    setContentView(HeadsUpTextView.alloc.initWithFrame(frame))
    setHasShadow(false)
    setIgnoresMouseEvents(true)
    setLevel(OSX::KCGDesktopWindowLevel)
    setOpaque(false)
    setReleasedWhenClosed(true)

    orderFront(self)
    self
  end

  def update_contents(string)
    string = right_justify(string) if @location == :bottom_right
    contentView.setString(bottom_justify(string))
  end

  private

  # FIXME this will blow up when there are more than ROWS lines
  def bottom_justify(string)
    lines = string.split(/\n/)
    (ROWS - lines.size).times { lines.unshift('') }
    lines.join("\n")
  end

  # FIXME this will blow up when there are more than COLS columns
  def right_justify(string)
    lines = string.split(/\n/)
    width = lines.map { |line| line.length }.max
    lines.map { |line| (' ' * (COLS - width)) + line }.join("\n")
  end

  def frame_for_location(location)
    main_frame = OSX::NSScreen.mainScreen.frame

    margin = FONT_HEIGHT
    width  = COLS * FONT_WIDTH
    height = ROWS * FONT_HEIGHT

    case location
    when :bottom_left
      [margin, margin, width, height]
    when :bottom_right
      [main_frame.width - width - margin, margin, width, height]
    else
      raise "Unsupported window location: #{location}"
    end
  end
end
