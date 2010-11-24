#import "HeadsUpWindowController.h"
#import "HeadsUpWindow.h"
#import "NSPipe+Reading.h"

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

// TODO private methods?
// TODO retain the task? Run synchronously?
- (void)launchTask:(NSString *)command {
	if ([[command stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
		[self updateText:@""];
	} else {
		NSTask *task = [[NSTask alloc] init];
		[task setLaunchPath:@"/bin/sh"];
		[task setArguments:[NSArray arrayWithObjects:@"-c", command, nil]];
		[task setStandardOutput:[NSPipe pipe]];
		[task setStandardError:[NSPipe pipe]];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidTerminate:) name:NSTaskDidTerminateNotification object:task];
		[task launch];
	}
}

// TODO is there a way to use a block form of task launching? (Blocks introduced in 10.6, I think...)
- (void)taskDidTerminate:(NSNotification *)notification {
	NSTask *task = [notification object];

	// TODO how to find real string encoding?
	if ([task terminationStatus] == 0) {
		[self updateText:[[task standardOutput] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];
	} else {
		[self updateText:[[task standardError] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];
	}

	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:task];
}

- (void)updateText:(NSString *)string {
	[(HeadsUpWindow *) [self window] updateText:string];
	[(HeadsUpWindow *) [self window] repositionOn:screen];
}

@end