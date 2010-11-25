#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	HeadsUpScreen *screen;
}

- (id)initWithScreen:(HeadsUpScreen *)screen;
- (void)headsUpScreenDidUpdate:(NSNotification *)notification;

@end