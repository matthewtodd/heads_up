#import "HeadsUpWindowController.h"


@implementation HeadsUpWindowController

- (id)initWithWindow:(NSWindow *)window screen:(id <HeadsUpScreen>)screen {
	self = [super initWithWindow:window];

	if (self) {
//		[self setScreen:screen];

		[[self window] orderFront:self];
	}

	return self;
}

@end
