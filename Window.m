#import "Command.h"
#import "HeadsUpTextView.h"
#import "Window.h"
#import "WindowPosition.h"

@implementation Window

@synthesize position;

- (id)initWithPosition:(WindowPosition *)thePosition observing:(Command *)theCommand {
	self = [super initWithContentRect:[thePosition windowFrame] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:[[HeadsUpTextView alloc] init]];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];
		[self setPosition:thePosition];

		[[self contentView] addObserver:self forKeyPath:@"string" options:0 context:nil];
		[[self contentView] bind:@"string" toObject:theCommand withKeyPath:@"output" options:nil];
		[[self contentView] setString:@"Launching..."];

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
	return [[self contentView] textSize];
}

- (void)reposition {
	[self setFrame:[position windowFrameWithSize:[self size]] display:TRUE];
}

@end