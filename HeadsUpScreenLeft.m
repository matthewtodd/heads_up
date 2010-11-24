#import "HeadsUpScreenLeft.h"

@implementation HeadsUpScreenLeft

// TODO autorelease the command?
- (Command *) command {
	return [[Command alloc] initWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"bottom_left"]];
}

- (NSRect) windowFrameWithSize:(NSSize)size {
	return NSMakeRect(12, 12, size.width, size.height);
}

@end
