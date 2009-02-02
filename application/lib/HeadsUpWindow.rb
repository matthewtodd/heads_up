require 'osx/cocoa'

class HeadsUpWindow < OSX::NSWindow
  def initWithLocation(location)
    @location = location

    initWithContentRect_styleMask_backing_defer(frame_for_location, OSX::NSBorderlessWindowMask, OSX::NSBackingStoreBuffered, false)
    setAutodisplay(true)
    setBackgroundColor(OSX::NSColor.clearColor)
    setHasShadow(false)
    setIgnoresMouseEvents(true)
    setLevel(OSX::KCGDesktopWindowLevel)
    setOpaque(false)
    setReleasedWhenClosed(true)

    text = OSX::NSTextView.alloc.initWithFrame(contentView.frame)
    text.setAllowsUndo(false)
    text.setBackgroundColor(OSX::NSColor.clearColor)
    text.setEditable(false)
    text.setFieldEditor(false)
    text.setFont(OSX::NSFont.fontWithName_size('Monaco', 12.0))
    text.setHorizontallyResizable(false)
    text.setSelectable(false)
    text.setTextColor(OSX::NSColor.whiteColor.colorWithAlphaComponent(0.5))
    text.setVerticallyResizable(false)
    text.textContainer.setWidthTracksTextView(false)
    text.textContainer.setHeightTracksTextView(false)
    setContentView(text)

    orderFront(self)
    self
  end

  def updateContents(string)
    contentView.setString(string.to_s.chomp)
    updatePosition
  end

  def updatePosition
    setFrame_display(frame_for_location, true)
  end

  private

  def frame_for_location
    send("frame_for_#{@location}", *content_dimensions)
  end

  MARGIN = 12.0

  def frame_for_bottom_left(width, height)
    [MARGIN, MARGIN, width, height]
  end

  def frame_for_bottom_right(width, height)
    main_frame = OSX::NSScreen.mainScreen.frame
    [main_frame.width - width - MARGIN, MARGIN, width, height]
  end

  def content_dimensions
    if contentView
      container = contentView.textContainer
      manager = contentView.layoutManager

      manager.glyphRangeForTextContainer(container) # trigger layout; without this we just get 0,0 for dimensions
      rect = manager.usedRectForTextContainer(container)
      width, height = rect.width, rect.height
    else
      width, height = ((OSX::NSScreen.mainScreen.frame.width / 2) - MARGIN * 2), 100
    end

    [width, height]
  end
end
