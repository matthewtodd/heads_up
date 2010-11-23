#import <Cocoa/Cocoa.h>

@protocol HeadsUpScreen
- (NSRect)initialContentRect;
- (NSString *) key;
- (NSRect)windowFrameWithSize:(NSSize)size;
@end