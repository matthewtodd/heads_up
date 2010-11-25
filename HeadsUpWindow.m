#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindow

- (id)init {
	self = [super initWithContentRect:NSMakeRect(0,0,100,100) styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	// TODO retain the contentView?
	if (self) {
		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:[[HeadsUpTextView alloc] init]];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];

		// Display the window.
		[self orderFront:self];
	}
	
	return self;
}

- (void)headsUpScreenDidUpdate:(NSNotification *)notification {
	HeadsUpScreen *screen = [notification object];
	[[self contentView] setString:[screen contents]];
	[self setFrame:[screen windowFrameWithSize:[(HeadsUpTextView *) [self contentView] textSize]] display:TRUE];
}

@end