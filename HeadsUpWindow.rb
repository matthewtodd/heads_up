require 'osx/cocoa'

class HeadsUpWindow < OSX::NSWindow
	def	init
		initWithContentRect_styleMask_backing_defer([12,12,600,192], OSX::NSBorderlessWindowMask, OSX::NSBackingStoreBuffered, false)
		
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
end
