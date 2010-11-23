#import "HeadsUpWindowController.h"

@implementation HeadsUpWindowController

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)screen {
	self = [super initWithWindow:[[HeadsUpWindow alloc] initWithHeadsUpScreen:screen]];

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