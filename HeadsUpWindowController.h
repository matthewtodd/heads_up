#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	id <HeadsUpScreen> screen;
}

- (id)initWithScreen:(id <HeadsUpScreen>)screen;
- (void)refresh:(NSNotification *)notification;
- (void)launchTask:(NSString *)command;
- (void)taskDidTerminate:(NSNotification *)notification;
- (NSString *)readPipe:(NSPipe *)pipe;
- (void)updateText:(NSString *)string;
@end