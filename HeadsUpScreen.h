#import "Command.h"

// TODO rename to (Window)Position
@interface HeadsUpScreen : NSObject {
	NSString *key;
}

- (id)initWithKey:(NSString *)key;
- (Command *)command;
- (NSRect)windowFrameWithSize:(NSSize)size;

@end