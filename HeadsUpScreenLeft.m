#import "HeadsUpScreenLeft.h"

@implementation HeadsUpScreenLeft

- (NSString *) command {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"bottom_left"];
}

- (NSRect) windowFrameWithSize:(NSSize)size {
	return NSMakeRect(12, 12, size.width, size.height);
}

@end
