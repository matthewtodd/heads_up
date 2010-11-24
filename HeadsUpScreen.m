#import "HeadsUpScreen.h"

@implementation HeadsUpScreen

- (id)initWithKey:(NSString *)theKey {
	self = [super init];
	if (self) {
		key = theKey;
	}
	return self;
}

// TODO autorelease the command?
- (Command *) command {
	return [[Command alloc] initWithString:[[NSUserDefaults standardUserDefaults] stringForKey:key]];
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