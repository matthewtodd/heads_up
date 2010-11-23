#import "HeadsUpScreen.h"

@interface HeadsUpWindow : NSWindow {
}

- (id)init;
- (void)setString:(NSString *)string andPositionOn:(id <HeadsUpScreen>)screen;

@end