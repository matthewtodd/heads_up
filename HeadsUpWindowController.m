#import "HeadsUpWindowController.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindowController

- (id)initWithScreen:(HeadsUpScreen *)theScreen {
	// TODO retain window?
	self = [super initWithWindow:[[HeadsUpWindow alloc] init]];

	if (self) {
		screen = theScreen;

		[self headsUpScreenDidUpdate:nil];
		[screen runCommand:nil];

		// TODO removeObserver
		// TODO use an NSInvocation to DRY things up?
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headsUpScreenDidUpdate:) name:HeadsUpScreenDidUpdateNotification object:screen];
		[NSTimer scheduledTimerWithTimeInterval:60 target:screen selector:@selector(runCommand:) userInfo:nil repeats:TRUE];
	}

	return self;
}

// TODO feature envy? Just call the window directly. (But would need to pass screen as well...)
- (void)headsUpScreenDidUpdate:(NSNotification *)notification {
	[(HeadsUpWindow *) [self window] updateText:[screen contents]];
	[(HeadsUpWindow *) [self window] repositionOn:screen];
}

@end