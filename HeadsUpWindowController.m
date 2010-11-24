#import "HeadsUpWindowController.h"
#import "HeadsUpWindow.h"
#import "Command.h"

@implementation HeadsUpWindowController

- (id)initWithScreen:(id <HeadsUpScreen>)theScreen {
	// TODO retain window?
	self = [super initWithWindow:[[HeadsUpWindow alloc] init]];

	if (self) {
		screen = theScreen;

		[self display:@"Launching..."];
		[self runCommand:nil];

		// TODO removeObserver
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runCommand:) name:NSUserDefaultsDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runCommand:) name:NSApplicationDidChangeScreenParametersNotification object:nil];
		[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(runCommand:) userInfo:nil repeats:TRUE];
	}

	return self;
}

- (void)display:(NSString *)string {
	[(HeadsUpWindow *) [self window] updateText:string];
	[(HeadsUpWindow *) [self window] repositionOn:screen];
}

- (void)runCommand:(NSNotification *)notification {
	[[screen command] runAndNotify:self selector:@selector(display:)];
}

@end