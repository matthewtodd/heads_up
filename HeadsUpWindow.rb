require 'osx/cocoa'

class HeadsUpWindow < OSX::NSWindow
	def	init
		initWithContentRect_styleMask_backing_defer([100,100,600,200], OSX::NSBorderlessWindowMask, OSX::NSBackingStoreBuffered, false)
		setAutodisplay(true)
		setHasShadow(false)
		setOpaque(false)
		setReleasedWhenClosed(true)
		orderFront(self)
		self
	end
end
