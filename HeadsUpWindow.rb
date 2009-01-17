require 'osx/cocoa'

class HeadsUpWindow < OSX::NSWindow
	def	initWithLocation(location)
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
	  contentView.setString(bottom_justify(string))
	end
	
	private
	
	def bottom_justify(string)
    lines = string.split(/\n/)
    (12 - lines.size).times { lines.unshift('') }
    lines.join("\n")
  end

	def frame_for_location(location)
	  main_frame = OSX::NSScreen.mainScreen.frame
	
	  margin = 12
	  width  = 600
	  height = 192
	
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
