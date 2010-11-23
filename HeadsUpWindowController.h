#import "HeadsUpScreen.h"
#import "HeadsUpWindow.h"

@interface HeadsUpWindowController : NSWindowController {
}

- (id)initWithHeadsUpWindow:(HeadsUpWindow *)window;
- (HeadsUpWindow *)headsUpWindow;
@end