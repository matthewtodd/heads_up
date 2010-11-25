#import "Command.h"
#import "Window.h"
#import "Position.h"

@implementation Window

- (void)buildViewObserving:(Command *)theCommand {
	NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
	[style setDefaultTabInterval:28.0];
	[style setTabStops:[NSArray array]];

	NSTextView *view = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, 10000, 10000)];
	
	[view setAllowsUndo:FALSE];
	[view setBackgroundColor: [NSColor clearColor]];
	[view setDefaultParagraphStyle:style];
	[view setEditable:FALSE];
	[view setFieldEditor:FALSE];
	[view setFont:[NSFont fontWithName:@"Menlo" size:12.0]];
	[view setHorizontallyResizable:FALSE];
	[view setSelectable:FALSE];
	[view setTextColor:[[NSColor whiteColor] colorWithAlphaComponent:0.5]];
	[view setVerticallyResizable:FALSE];
	
	[[view textContainer] setHeightTracksTextView:FALSE];
	[[view textContainer] setWidthTracksTextView:FALSE];
	
	[self setContentView:view];
	
	[view addObserver:self forKeyPath:@"string" options:0 context:nil];
	[view bind:@"string" toObject:theCommand withKeyPath:@"output" options:nil];
	[view setString:@"Launching..."];
}

- (id)initWithPosition:(Position *)thePosition observing:(Command *)theCommand {
	self = [super initWithContentRect:[thePosition windowFrame] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		position = thePosition;

		[self setBackgroundColor: [NSColor clearColor]];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];
		[self buildViewObserving:theCommand];

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