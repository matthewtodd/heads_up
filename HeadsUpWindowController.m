#import "HeadsUpWindowController.h"

@implementation HeadsUpWindowController

- (id)initWithWindow:(NSWindow *)window {
	self = [super initWithWindow:window];

	if (self) {
//		[[self window] position];
		[[self window] orderFront:self];
	}

	return self;
}

@end