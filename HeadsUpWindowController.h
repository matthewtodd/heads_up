#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
}

- (id)initWithWindow:(NSWindow *)window screen:(id <HeadsUpScreen>)screen;

@end