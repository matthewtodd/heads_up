#import "HeadsUpScreen.h"

@interface HeadsUpWindow : NSWindow {
}

- (id)initWithContentView:(NSView *)contentView screen:(id <HeadsUpScreen>)screen;

@end