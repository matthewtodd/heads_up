#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	id <HeadsUpScreen> screen;
}

- (id)initWithScreen:(id <HeadsUpScreen>)screen;
- (void)refresh:(NSNotification *)notification;
- (void)launchTask:(NSString *)command;
- (void)updateText:(NSString *)string;
@end