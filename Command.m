#import "Command.h"

@implementation Command

@synthesize key;
@synthesize output;
@synthesize timer;

- (id)initWithKey:(NSString *)theKey {
	self = [super init];

	if (self) {
		[self setKey:theKey];
		[self setTimer:[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(trigger:) userInfo:nil repeats:TRUE]];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trigger:) name:NSUserDefaultsDidChangeNotification object:nil];
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

- (void) trigger:(NSNotification *)notification {
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:@"/bin/sh"];
	[task setArguments:[NSArray arrayWithObjects:@"-c", [self command], nil]];
	[task setStandardOutput:[NSPipe pipe]];
	[task setStandardError:[NSPipe pipe]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidTerminate:) name:NSTaskDidTerminateNotification object:task];
	[task launch];
}

- (NSString *)readStringToEndOfPipe:(NSPipe *)pipe withEncoding:(NSStringEncoding)encoding {
	return [[NSString alloc] initWithData:[[pipe fileHandleForReading] readDataToEndOfFile] encoding:encoding];
}

- (void)taskDidTerminate:(NSNotification *)notification {
	NSTask *task = [notification object];
	NSPipe *outputPipe = ([task terminationStatus] == 0) ? [task standardOutput] : [task standardError];

	// TODO how to find real string encoding? At the Terminal, can use `locale charmap`.
	[self setOutput:[self readStringToEndOfPipe:outputPipe withEncoding:NSUTF8StringEncoding]];

	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:task];
}

@end