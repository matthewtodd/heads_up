#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
	id <HeadsUpScreen> headsUpScreen;
}

@property (assign) id <HeadsUpScreen> headsUpScreen;

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)screen;
- (void)launchTask:(NSString *)command;
- (void)taskDidTerminate:(NSNotification *)notification;
- (void)updateTextFromPipe:(NSPipe *)pipe;
- (void)updateText:(NSString *)string;
@end