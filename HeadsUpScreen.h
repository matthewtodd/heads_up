#import <Cocoa/Cocoa.h>

@protocol HeadsUpScreen
- (NSString *) command;
- (NSRect)windowFrameWithSize:(NSSize)size;
@end