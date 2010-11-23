#import "HeadsUpWindowController.h"

@implementation HeadsUpWindowController

- (id)initWithWindow:(NSWindow *)window {
	self = [super initWithWindow:window];

	if (self) {
		[[self window] setString:@"Hello, World!"];
		[[self window] orderFront:self];
	}

	return self;
}

@end