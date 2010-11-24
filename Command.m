#import "Command.h"
#import "NSPipe+Reading.h"
#import "NSString+Predicates.h"

@implementation Command

- (id)initWithString:(NSString *)theString observer:(id)theObserver selector:(SEL)theSelector {
	self = [super init];
	if (self) {
		string = theString;
		observer = theObserver;
		selector = theSelector;
	}
	return self;
}

// TODO retain the task?
- (void)run {
	if ([string isPresent]) {
		NSTask *task = [[NSTask alloc] init];
		[task setLaunchPath:@"/bin/sh"];
		[task setArguments:[NSArray arrayWithObjects:@"-c", string, nil]];
		[task setStandardOutput:[NSPipe pipe]];
		[task setStandardError:[NSPipe pipe]];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidTerminate:) name:NSTaskDidTerminateNotification object:task];
		[task launch];
	} else {
		[observer performSelector:selector withObject:@""];
	}
}

- (void)taskDidTerminate:(NSNotification *)notification {
	NSTask *task = [notification object];

	// TODO how to find real string encoding?
	if ([task terminationStatus] == 0) {
		[observer performSelector:selector withObject:[[task standardOutput] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];
	} else {
		[observer performSelector:selector withObject:[[task standardError] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];
	}

	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:task];
}

@end