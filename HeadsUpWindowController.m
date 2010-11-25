#import "HeadsUpWindowController.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindowController

- (id)initWithScreen:(HeadsUpScreen *)theScreen {
	// TODO retain window?
	self = [super initWithWindow:[[HeadsUpWindow alloc] init]];

	if (self) {
		screen = theScreen;

		// TODO perhaps the screen would handle this string?
		[self display:@"Launching..."];
		[screen runCommand:nil];

		// TODO removeObserver
		// TODO use an NSInvocation to DRY things up?
		// TODO the HeadsUpScreen cares about the user defaults -- maybe it should subscribe instead?
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headsUpScreenDidUpdate:) name:HeadsUpScreenDidUpdateNotification object:screen];
		[[NSNotificationCenter defaultCenter] addObserver:screen selector:@selector(runCommand:) name:NSUserDefaultsDidChangeNotification object:nil];
		[NSTimer scheduledTimerWithTimeInterval:60 target:screen selector:@selector(runCommand:) userInfo:nil repeats:TRUE];
	}

	return self;
}

- (void)headsUpScreenDidUpdate:(NSNotification *)notification {
	[self display:[screen contents]];
}

// TODO feature envy? Just call the window directly. (But would need to pass screen as well...)
- (void)display:(NSString *)string {
	[(HeadsUpWindow *) [self window] updateText:string];
	[(HeadsUpWindow *) [self window] repositionOn:screen];
}

@end