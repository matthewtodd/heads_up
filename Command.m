#import "Command.h"
#import "NSPipe+Reading.h"

@implementation Command

- (id)initWithString:(NSString *)theString {
	self = [super init];
	if (self) {
		string = theString;
	}
	return self;
}

// TODO retain the task?
- (void)runAndNotify:(id)observer selector:(SEL)selector {
	if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
		[observer performSelector:selector withObject:@""];
	} else {
		NSTask *task = [[NSTask alloc] init];
		[task setLaunchPath:@"/bin/sh"];
		[task setArguments:[NSArray arrayWithObjects:@"-c", string, nil]];
		[task setStandardOutput:[NSPipe pipe]];
		[task setStandardError:[NSPipe pipe]];
		[task launch];
		[task waitUntilExit];
		// TODO how to find real string encoding?
		if ([task terminationStatus] == 0) {
			[observer performSelector:selector withObject:[[task standardOutput] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];
		} else {
			[observer performSelector:selector withObject:[[task standardError] readStringToEndOfFileWithEncoding:NSUTF8StringEncoding]];
		}
	}
}

@end
