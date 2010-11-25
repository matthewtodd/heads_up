#import "HeadsUpScreen.h"
#import "WindowPosition.h"

@interface HeadsUpWindow : NSWindow {
	WindowPosition *position;
}

- (id)initWithPosition:(WindowPosition *)position;
- (void)observeScreen:(HeadsUpScreen *)screen;
- (void)reposition;

@end