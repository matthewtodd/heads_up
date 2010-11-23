#import "HeadsUpWindowController.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpWindowController

@synthesize headsUpScreen;

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)screen {
	self = [super initWithWindow:[[HeadsUpWindow alloc] initWithHeadsUpScreen:screen]];

	if (self) {
		[self setHeadsUpScreen:screen];
		[self launchTask:[[NSUserDefaults standardUserDefaults] stringForKey:[screen key]]];
	}

	return self;
}

// TODO retain the task?
- (void)launchTask:(NSString *)command {
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:@"/bin/sh"];
	[task setArguments:[NSArray arrayWithObjects:@"-c", command, nil]];
	[task setStandardOutput:[NSPipe pipe]];
	[task setStandardError:[NSPipe pipe]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidTerminate:) name:NSTaskDidTerminateNotification object:task];
	[task launch];
}

// TODO is there a way to use a block form of task launching? (Blocks introduced in 10.6, I think...)
- (void)taskDidTerminate:(NSNotification *)notification {
	NSTask *task = [notification object];

	if ([task terminationStatus] == 0) {
		[self setDataFromPipe:[task standardOutput]];
	} else {
		[self setDataFromPipe:[task standardError]];
	}

	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:task];
}

// TODO how to read real string encoding?
// TODO retain the string?
- (void)setDataFromPipe:(NSPipe *)pipe {
	NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
	NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	[self setString:string];
}

- (void)setString:(NSString *)string {
	[(HeadsUpWindow *) [self window] setString:string];
}

@end