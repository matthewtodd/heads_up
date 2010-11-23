#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindow

@synthesize headsUpScreen;

- (id)initWithContentView:(NSView *)contentView headsUpScreen:(id <HeadsUpScreen>)theHeadsUpScreen {
	self = [super initWithContentRect:[theHeadsUpScreen initialContentRect] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		[self setAutodisplay:TRUE];
		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:contentView];
		[self setHasShadow:FALSE];
		[self setHeadsUpScreen:theHeadsUpScreen];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];
		[self setReleasedWhenClosed:TRUE];
	}
	
	return self;
}

- (HeadsUpTextView *) headsUpContentView {
	return (HeadsUpTextView *) [self contentView];
}

- (void)setString:(NSString *)string {
	[[self contentView] setString:string];
	[self setFrame:[[self headsUpScreen] windowFrameForTextRect:[[self headsUpContentView] usedTextRectangle]] display:TRUE];
}

@end