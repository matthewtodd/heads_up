#import "HeadsUpScreenRight.h"

@implementation HeadsUpScreenRight

- (NSString *) command {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"bottom_right"];
}

- (NSRect) initialContentRect {
	int screenWidth = [[NSScreen mainScreen] frame].size.width;
	int windowWidth = (screenWidth / 2) - 24;

	return NSMakeRect(screenWidth - windowWidth - 12, 12, windowWidth, 100);
}

- (NSRect) windowFrameWithSize:(NSSize)size {
	int screenWidth = [[NSScreen mainScreen] frame].size.width;

	return NSMakeRect(screenWidth - size.width - 12, 12, size.width, size.height);
}

@end