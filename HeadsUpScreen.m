#import "HeadsUpScreen.h"
#import "NSPipe+Reading.h"
#import "NSString+Predicates.h"

@implementation HeadsUpScreen

// TODO can almost now set up contents for key-value observing???
@synthesize contents;

- (id)initWithKey:(NSString *)theKey {
	self = [super init];
	if (self) {
		key = theKey;
		contents = nil;
	}
	return self;
}

- (void) runCommand {
	NSString *command = [[NSUserDefaults standardUserDefaults] stringForKey:key];

	if ([command isPresent]) {
		NSTask *task = [[NSTask alloc] init];
		[task setLaunchPath:@"/bin/sh"];
		[task setArguments:[NSArray arrayWithObjects:@"-c", command, nil]];
		[task setStandardOutput:[NSPipe pipe]];
		[task setStandardError:[NSPipe pipe]];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidTerminate:) name:NSTaskDidTerminateNotification object:task];
		[task launch];
	} else {
		contents = @"";
		[[NSNotificationCenter defaultCenter] postNotificationName:HeadsUpScreenDidUpdateNotification object:self];
	}
}

- (void)taskDidTerminate:(NSNotification *)notification {
	NSTask *task = [notification object];

	// TODO how to find real string encoding? At the Terminal, can use `locale charmap`.
	if ([task terminationStatus] == 0) {
		contents = [[task standardOutput] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding];
	} else {
		contents = [[task standardError] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding];
	}

	[[NSNotificationCenter defaultCenter] postNotificationName:HeadsUpScreenDidUpdateNotification object:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSTaskDidTerminateNotification object:task];
}

- (NSRect) windowFrameWithSize:(NSSize)size {
	int left;
	
	if ([key rangeOfString:@"right"].location == NSNotFound) {
		left = 12;
	} else {
		left = [[NSScreen mainScreen] frame].size.width - size.width - 12;
	}
	
	return NSMakeRect(left, 12, size.width, size.height);
}

@end

NSString * const HeadsUpScreenDidUpdateNotification = @"HeadsUpScreenDidUpdateNotification";