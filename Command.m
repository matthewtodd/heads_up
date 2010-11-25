#import "Command.h"
#import "NSPipe+Reading.h"

@implementation Command

@synthesize key;
@synthesize output;
@synthesize timer;

- (id)initWithKey:(NSString *)theKey {
	self = [super init];
	if (self) {
		[self setKey:theKey];
		[self setTimer:[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(runCommand:) userInfo:nil repeats:TRUE]];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runCommand:) name:NSUserDefaultsDidChangeNotification object:nil];
		[[self timer] fire];
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
	NSPipe *outputPipe = ([task terminationStatus] == 0) ? [task standardOutput] : [task standardError];

	// TODO how to find real string encoding? At the Terminal, can use `locale charmap`.
	[self setOutput:[outputPipe readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];

	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:task];
}

@end