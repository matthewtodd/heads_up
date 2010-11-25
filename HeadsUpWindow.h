#import "HeadsUpScreen.h"
#import "WindowPosition.h"

@interface HeadsUpWindow : NSWindow {
	WindowPosition *position;
}

- (id)initWithPosition:(WindowPosition *)position;
- (void)reposition;

@end