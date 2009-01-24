require 'osx/cocoa'

class HeadsUpWindow < OSX::NSWindow
  ROWS, COLS = 12, 80

  # FIXME chicken-and-egg keeps me from asking
  # layoutManger.defaultLineHeightForFont. So resize window, textView, *after*
  # initializing? Aternatively, maybe I could grow the window to accomodate
  # its textView?
  FONT_HEIGHT, FONT_WIDTH = 16.0, 7.201171875

  def initWithLocation(location)
    @location = location

    initWithContentRect_styleMask_backing_defer(frame_for_location, OSX::NSBorderlessWindowMask, OSX::NSBackingStoreBuffered, false)
    setAutodisplay(true)
    setBackgroundColor(OSX::NSColor.clearColor)
    setContentView(HeadsUpTextView.alloc.initWithFrame(frame))
    # FIXME this setAlignment call belongs somewhere else
    contentView.setAlignment(OSX::NSRightTextAlignment) if location == :bottom_right
    setHasShadow(false)
    setIgnoresMouseEvents(true)
    setLevel(OSX::KCGDesktopWindowLevel)
    setOpaque(false)
    setReleasedWhenClosed(true)
    orderFront(self)

    self
  end

  # FIXME contentView.setString isn't working with tabs?!?
  def updateContents(string)
    contentView.setString(bottom_justify(string))
  end

  def updatePosition
    setFrame_display(frame_for_location, true)
  end

  private

  # FIXME rather than all this string padding, is it better to resize the textView??? (Better how?)
  # FIXME this will blow up when there are more than ROWS lines
  def bottom_justify(string)
    lines = string.split(/\n/)
    (ROWS - lines.size).times { lines.unshift('') }
    lines.join("\n")
  end

  def frame_for_location
    main_frame = OSX::NSScreen.mainScreen.frame

    margin = FONT_HEIGHT
    width  = COLS * FONT_WIDTH
    height = ROWS * FONT_HEIGHT

    case @location
    when :bottom_left
      [margin, margin, width, height]
    when :bottom_right
      [main_frame.width - width - margin, margin, width, height]
    else
      raise "Unsupported window location: #{location}"
    end
  end
end
