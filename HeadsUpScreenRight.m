#import "HeadsUpScreenRight.h"

@implementation HeadsUpScreenRight

- (NSRect) initialContentRect {
	int screenWidth = [[NSScreen mainScreen] frame].size.width;
	int windowWidth = (screenWidth / 2) - 24;

	return NSMakeRect(screenWidth - windowWidth - 12, 12, windowWidth, 100);
}

@end