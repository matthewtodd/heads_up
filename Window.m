#import "Command.h"
#import "ContentSizedTextView.h"
#import "Position.h"
#import "Window.h"

@implementation Window

- (id)initWithPosition:(Position *)thePosition {
	self = [super initWithContentRect:[thePosition windowFrame] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		position = thePosition;

		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:[[ContentSizedTextView alloc] initWithFrame:NSMakeRect(0, 0, 10000, 10000)]];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];

		[[self contentView] addObserver:self forKeyPath:@"string" options:0 context:nil];

		[self orderFront:self];
	}
	
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([object isEqualTo:[self contentView]] && [keyPath isEqualToString:@"string"]) {
		[self reposition];
	}
}

- (void)reposition {
	[self setFrame:[position windowFrameWithSize:[[self contentView] textSize]] display:TRUE];
}

@end