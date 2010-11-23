#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
}

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)screen;
- (void)launchTask:(NSString *)command;
- (void)taskDidTerminate:(NSNotification *)notification;
- (void)setDataFromPipe:(NSPipe *)pipe;
- (void)setString:(NSString *)string;
@end