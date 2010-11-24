#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	HeadsUpScreen *screen;
}

- (id)initWithScreen:(HeadsUpScreen *)screen;
- (void)display:(NSString *)string;
- (void)runCommand:(NSNotification *)notification;

@end