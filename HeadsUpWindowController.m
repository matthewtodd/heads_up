#import "HeadsUpWindowController.h"
#import "HeadsUpWindow.h"
#import "Command.h"

@implementation HeadsUpWindowController

- (id)initWithScreen:(id <HeadsUpScreen>)theScreen {
	// TODO retain window?
	self = [super initWithWindow:[[HeadsUpWindow alloc] init]];

	if (self) {
		screen = theScreen;

		[self updateText:@"Launching..."];
		[self refresh:nil];

		// TODO removeObserver
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:NSUserDefaultsDidChangeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:NSApplicationDidChangeScreenParametersNotification object:nil];
		[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refresh:) userInfo:nil repeats:TRUE];
	}

	return self;
}

- (void)refresh:(NSNotification *)notification {
	[self launchTask:[screen command]];
}

- (void)launchTask:(NSString *)string {
	Command *command = [[Command alloc] initWithString:string];
	[command runAndNotify:self selector:@selector(updateText:)];
}

- (void)updateText:(NSString *)string {
	[(HeadsUpWindow *) [self window] updateText:string];
	[(HeadsUpWindow *) [self window] repositionOn:screen];
}

@end