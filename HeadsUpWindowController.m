#import "HeadsUpWindowController.h"

@implementation HeadsUpWindowController

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)screen {
	self = [super initWithWindow:[[HeadsUpWindow alloc] initWithHeadsUpScreen:screen]];

	if (self) {
		[[self headsUpWindow] setString:@"Loading..."];
		[[self headsUpWindow] orderFront:self];

		[self launchTask:@"/usr/bin/true"];
	}

	return self;
}

- (HeadsUpWindow *)headsUpWindow {
	return (HeadsUpWindow *) [self window];
}

// TODO retain the task?
- (void)launchTask:(NSString *)command {
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:@"/bin/sh"];
	[task setArguments:[NSArray arrayWithObjects:@"-c", command, nil]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidTerminate:) name:NSTaskDidTerminateNotification object:task];
	[task launch];
}

// TODO read stdout/stderr.
- (void)taskDidTerminate:(NSNotification *)notification {
	NSTask *task = [notification object];

	if ([task terminationStatus] == 0) {
		[[self headsUpWindow] setString:@"Success!"];
	} else {
		[[self headsUpWindow] setString:@"Failure."];
	}

	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:task];
}

@end