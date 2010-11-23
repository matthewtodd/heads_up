#import <Cocoa/Cocoa.h>

@protocol HeadsUpScreen
- (NSRect)initialContentRect;
- (NSString *) command;
- (NSRect)windowFrameWithSize:(NSSize)size;
@end