#import <Cocoa/Cocoa.h>
#import "Command.h"

// TODO make a class, not a protocol
// TODO rename to (Window)Position
@protocol HeadsUpScreen
- (Command *) command;
- (NSRect)windowFrameWithSize:(NSSize)size;
@end