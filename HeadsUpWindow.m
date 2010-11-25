#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindow

- (id)initWithPosition:(WindowPosition *)thePosition {
	self = [super initWithContentRect:[thePosition windowFrameWithSize:NSMakeSize(100, 100)] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		position = thePosition;

		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:[[HeadsUpTextView alloc] init]];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];
	}
	
	return self;
}

- (void)headsUpScreenDidUpdate:(NSNotification *)notification {
	HeadsUpScreen *screen = [notification object];
	[[self contentView] setString:[screen contents]];
	[self setFrame:[position windowFrameWithSize:[(HeadsUpTextView *) [self contentView] textSize]] display:TRUE];
}

@end