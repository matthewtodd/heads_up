#import "HeadsUpScreenLeft.h"

@implementation HeadsUpScreenLeft

- (NSRect) initialContentRect {
	int screenWidth = [[NSScreen mainScreen] frame].size.width;
	int windowWidth = (screenWidth / 2) - 24;

	return NSMakeRect(12, 12, windowWidth, 100);
}

- (NSRect) windowFrameForTextRect:(NSRect)textRect {
	return NSMakeRect(12, 12, textRect.size.width, textRect.size.height);
}

@end
