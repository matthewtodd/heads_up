#import "HeadsUpWindowController.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindowController

- (id)initWithScreen:(HeadsUpScreen *)theScreen {
	// TODO retain window?
	self = [super initWithWindow:[[HeadsUpWindow alloc] init]];

	if (self) {
		screen = theScreen;

		[[NSNotificationCenter defaultCenter] addObserver:[self window] selector:@selector(headsUpScreenDidUpdate:) name:HeadsUpScreenDidUpdateNotification object:screen];
		[[NSNotificationCenter defaultCenter] postNotificationName:HeadsUpScreenDidUpdateNotification object:screen];
		[screen runCommand:nil];

		// TODO removeObserver
		// TODO use an NSInvocation to DRY things up?
		[NSTimer scheduledTimerWithTimeInterval:60 target:screen selector:@selector(runCommand:) userInfo:nil repeats:TRUE];
	}

	return self;
}

@end