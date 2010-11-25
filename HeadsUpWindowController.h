#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	HeadsUpScreen *screen;
}

- (id)initWithScreen:(HeadsUpScreen *)screen;

@end