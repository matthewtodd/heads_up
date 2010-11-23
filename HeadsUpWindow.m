#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindow

@synthesize headsUpScreen;

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)theHeadsUpScreen {
	self = [super initWithContentRect:[theHeadsUpScreen initialContentRect] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:[[HeadsUpTextView alloc] init]];
		[self setHeadsUpScreen:theHeadsUpScreen];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];

		// Display the window.
		[self orderFront:self];
	}
	
	return self;
}

- (void)setString:(NSString *)string {
	NSInteger i = [string length];
	while ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:[string characterAtIndex:(i-1)]]) {
		i--;
	}
	[[self contentView] setString:[string substringToIndex:i]];
	[self setFrame:[[self headsUpScreen] windowFrameWithSize:[(HeadsUpTextView *) [self contentView] textSize]] display:TRUE];
}

@end