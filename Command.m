#import "Command.h"
#import "NSPipe+Reading.h"

@implementation Command

@synthesize key;
@synthesize output;

- (id)initWithKey:(NSString *)theKey {
	self = [super init];
	if (self) {
		[self setKey:theKey];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runCommand:) name:NSUserDefaultsDidChangeNotification object:nil];
		[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(runCommand:) userInfo:nil repeats:TRUE];
	}
	return self;
}

- (NSString *)command {
	NSString *result = [[NSUserDefaults standardUserDefaults] stringForKey:key];
	if (result == nil) {
		result = @"# Not really running anything.";
	}
	return result;
}

- (void) runCommand:(NSNotification *)notification {
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:@"/bin/sh"];
	[task setArguments:[NSArray arrayWithObjects:@"-c", [self command], nil]];
	[task setStandardOutput:[NSPipe pipe]];
	[task setStandardError:[NSPipe pipe]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidTerminate:) name:NSTaskDidTerminateNotification object:task];
	[task launch];
}

- (void)taskDidTerminate:(NSNotification *)notification {
	NSTask *task = [notification object];

	// TODO how to find real string encoding? At the Terminal, can use `locale charmap`.
	if ([task terminationStatus] == 0) {
		[self setOutput:[[task standardOutput] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];
	} else {
		[self setOutput:[[task standardError] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];
	}

	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:task];
}

@end