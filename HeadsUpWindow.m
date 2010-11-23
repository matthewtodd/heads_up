#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindow

@synthesize headsUpScreen;

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)theHeadsUpScreen {
	self = [super initWithContentRect:[theHeadsUpScreen initialContentRect] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		[self setAutodisplay:TRUE];
		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:[[HeadsUpTextView alloc] init]];
		[self setHasShadow:FALSE];
		[self setHeadsUpScreen:theHeadsUpScreen];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];
		[self setReleasedWhenClosed:TRUE];
	}
	
	return self;
}

- (void)setString:(NSString *)string {
	[[self contentView] setString:string];
	[self setFrame:[[self headsUpScreen] windowFrameForTextRect:[(HeadsUpTextView *) [self contentView] usedTextRectangle]] display:TRUE];
}

@end