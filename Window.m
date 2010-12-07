#import "Command.h"
#import "ContentSizedTextView.h"
#import "Position.h"
#import "Window.h"

@implementation Window

- (id)initWithPosition:(Position *)thePosition observing:(Command *)theCommand {
	self = [super initWithContentRect:[thePosition windowFrame] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		position = thePosition;

		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:[[ContentSizedTextView alloc] initWithFrame:NSMakeRect(0, 0, 10000, 10000)]];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];

		[[self contentView] addObserver:self forKeyPath:@"string" options:0 context:nil];
		[[self contentView] bind:@"string" toObject:theCommand withKeyPath:@"output" options:nil];

		[self orderFront:self];
	}
	
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([object isEqualTo:[self contentView]] && [keyPath isEqualToString:@"string"]) {
		[self reposition];
	}
}

- (NSSize)size {
	// Trigger a layout, otherwise we just get 0,0 for dimensions!?
	[[[self contentView] layoutManager] glyphRangeForTextContainer:[[self contentView] textContainer]];
	return [[[self contentView] layoutManager] usedRectForTextContainer:[[self contentView] textContainer]].size;
}

- (void)reposition {
	[self setFrame:[position windowFrameWithSize:[self size]] display:TRUE];
}

@end