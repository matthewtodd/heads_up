#import "HeadsUpScreen.h"
#import "HeadsUpWindow.h"

@interface HeadsUpWindowController : NSWindowController {
}

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)screen;
- (HeadsUpWindow *)headsUpWindow;
- (void)launchTask:(NSString *)command;
- (void)taskDidTerminate:(NSNotification *)notification;
@end