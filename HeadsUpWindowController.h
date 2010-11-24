#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	id <HeadsUpScreen> screen;
}

- (id)initWithScreen:(id <HeadsUpScreen>)screen;
- (void)runCommand:(NSNotification *)notification;
- (void)display:(NSString *)string;

@end