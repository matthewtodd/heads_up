#import "HeadsUpScreen.h"

@interface HeadsUpWindow : NSWindow {
}

- (id)init;
- (void)headsUpScreenDidUpdate:(NSNotification *)notification;
- (void)updateText:(NSString *)string;
- (void)repositionOn:(HeadsUpScreen *)screen;

@end