#import "HeadsUpScreen.h"

@interface HeadsUpWindow : NSWindow {
}

- (id)init;
- (void)updateText:(NSString *)string;
- (void)repositionOn:(HeadsUpScreen *)screen;

@end