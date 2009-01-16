require 'osx/cocoa'

class HeadsUpWindow < OSX::NSWindow
	def	initWithLocation(location)
		initWithContentRect_styleMask_backing_defer(frame_for_location(location), OSX::NSBorderlessWindowMask, OSX::NSBackingStoreBuffered, false)
		
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
	
	private
	
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
