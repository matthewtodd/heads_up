#import "HeadsUpWindow.h"

@implementation HeadsUpWindow

- (id)initWithContentView:(NSView *)contentView screen:(id <HeadsUpScreen>)screen {
	self = [super initWithContentRect:[screen initialContentRect] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		[self setAutodisplay:TRUE];
		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:contentView];
		[self setHasShadow:FALSE];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];
		[self setReleasedWhenClosed:TRUE];
	}
	
	return self;
}

@end