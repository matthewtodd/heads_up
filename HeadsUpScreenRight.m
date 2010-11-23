#import "HeadsUpScreenRight.h"

@implementation HeadsUpScreenRight

- (NSString *) command {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"bottom_right"];
}

- (NSRect) windowFrameWithSize:(NSSize)size {
	int screenWidth = [[NSScreen mainScreen] frame].size.width;

	return NSMakeRect(screenWidth - size.width - 12, 12, size.width, size.height);
}

@end