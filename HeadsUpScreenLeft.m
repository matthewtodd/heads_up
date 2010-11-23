#import "HeadsUpScreenLeft.h"

@implementation HeadsUpScreenLeft

- (NSRect) initialContentRect {
	int screenWidth = [[NSScreen mainScreen] frame].size.width;
	int windowWidth = (screenWidth / 2) - 24;

	return NSMakeRect(12, 12, windowWidth, 100);
}

- (NSString *) key {
	return @"bottom_left";
}

- (NSRect) windowFrameWithSize:(NSSize)size {
	return NSMakeRect(12, 12, size.width, size.height);
}

@end
