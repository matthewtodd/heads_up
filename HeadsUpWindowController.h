#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	id <HeadsUpScreen> screen;
}

- (id)initWithScreen:(id <HeadsUpScreen>)screen;
- (void)display:(NSString *)string;
- (void)runCommand:(NSNotification *)notification;

@end