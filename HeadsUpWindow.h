#import "HeadsUpScreen.h"

@interface HeadsUpWindow : NSWindow {
}

- (id)init;
- (void)updateText:(NSString *)string andRepositionOn:(id <HeadsUpScreen>)screen;

@end