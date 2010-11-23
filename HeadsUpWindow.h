#import "HeadsUpScreen.h"

@interface HeadsUpWindow : NSWindow {
}

- (id)init;
- (void)updateText:(NSString *)string;
- (void)repositionOn:(id <HeadsUpScreen>)screen;

@end