#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	id <HeadsUpScreen> screen;
	NSTimer *timer;
}

- (id)initWithScreen:(id <HeadsUpScreen>)screen;
- (void)launchTask:(NSString *)command;
- (void)taskDidTerminate:(NSNotification *)notification;
- (NSString *)readPipe:(NSPipe *)pipe;
- (void)updateText:(NSString *)string;
@end