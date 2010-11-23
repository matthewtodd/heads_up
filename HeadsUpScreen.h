#import <Cocoa/Cocoa.h>

@protocol HeadsUpScreen
- (NSRect)initialContentRect;
- (NSRect)windowFrameWithSize:(NSSize)size;
@end