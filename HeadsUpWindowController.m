#import "HeadsUpWindowController.h"

@implementation HeadsUpWindowController

- (id)initWithHeadsUpWindow:(HeadsUpWindow *)window {
	self = [super initWithWindow:window];

	if (self) {
		[[self headsUpWindow] setString:@"Hello, World!"];
		[[self headsUpWindow] orderFront:self];
	}

	return self;
}

- (HeadsUpWindow *)headsUpWindow {
	return (HeadsUpWindow *) [self window];
}

@end