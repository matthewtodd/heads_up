#import <Cocoa/Cocoa.h>
#import "Command.h"

@protocol HeadsUpScreen
- (Command *) command;
- (NSRect)windowFrameWithSize:(NSSize)size;
@end