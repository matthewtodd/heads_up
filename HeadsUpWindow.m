#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindow

- (id)initWithPosition:(WindowPosition *)thePosition {
	self = [super initWithContentRect:[thePosition windowFrame] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

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

- (void)observeScreen:(HeadsUpScreen *)screen {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headsUpScreenDidUpdate:) name:HeadsUpScreenDidUpdateNotification object:screen];
}

- (NSSize)size {
	return [[self contentView] textSize];
}

- (void)reposition {
	[self setFrame:[position windowFrameWithSize:[self size]] display:TRUE];
}

- (void)setString:(NSString *)string {
	[[self contentView] setString:string];
}

- (void)headsUpScreenDidUpdate:(NSNotification *)notification {
	[self setString:[[notification object] contents]];
	[self reposition];
}

@end