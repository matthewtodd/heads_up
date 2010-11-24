#import "HeadsUpScreen.h"
#import "Command.h"

@implementation HeadsUpScreen

- (id)initWithKey:(NSString *)theKey {
	self = [super init];
	if (self) {
		key = theKey;
	}
	return self;
}

// TODO autorelease the command?
- (void) runCommandAndNotify:(id)observer selector:(SEL)selector {
	[[[Command alloc] initWithString:[[NSUserDefaults standardUserDefaults] stringForKey:key] observer:observer selector:selector] run];
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