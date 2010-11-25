#import "HeadsUpScreen.h"
#import "WindowPosition.h"

@interface HeadsUpWindow : NSWindow {
	WindowPosition *position;
}

@property WindowPosition *position;

- (id)initWithPosition:(WindowPosition *)position observing:(HeadsUpScreen *)screen;
- (void)reposition;

@end