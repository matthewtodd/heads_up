#import "HeadsUpScreenRight.h"

@implementation HeadsUpScreenRight

// TODO autorelease the command?
- (Command *) command {
	return [[Command alloc] initWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"bottom_right"]];
}

- (NSRect) windowFrameWithSize:(NSSize)size {
	int screenWidth = [[NSScreen mainScreen] frame].size.width;

	return NSMakeRect(screenWidth - size.width - 12, 12, size.width, size.height);
}

@end