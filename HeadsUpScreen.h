#import <Cocoa/Cocoa.h>

@protocol HeadsUpScreen
- (NSString *) command;
- (NSRect)initialContentRect;
- (NSRect)windowFrameWithSize:(NSSize)size;
@end