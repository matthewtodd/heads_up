#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindow

- (id)initWithPosition:(WindowPosition *)thePosition {
	self = [super initWithContentRect:[thePosition windowFrame] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		position = thePosition;

		HeadsUpTextView *view = [[HeadsUpTextView alloc] init];

		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:view];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];

		[view addObserver:self forKeyPath:@"string" options:0 context:nil];
	}
	
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	[self reposition];
}

// TODO fold this into the initializer
- (void)observeScreen:(HeadsUpScreen *)screen {
	[[self contentView] bind:@"string" toObject:screen withKeyPath:@"contents" options:nil];
}

- (NSSize)size {
	return [[self contentView] textSize];
}

- (void)reposition {
	[self setFrame:[position windowFrameWithSize:[self size]] display:TRUE];
}

@end