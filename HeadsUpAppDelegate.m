#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreenLeft.h"
#import "HeadsUpScreenRight.h"
#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	id <HeadsUpScreen> leftScreen  = [[HeadsUpScreenLeft alloc] init];
	id <HeadsUpScreen> rightScreen = [[HeadsUpScreenRight alloc] init];

	left  = [[HeadsUpWindowController alloc] initWithWindow:[[HeadsUpWindow alloc] initWithContentView:[[HeadsUpTextView alloc] initWithFrame:[leftScreen initialContentRect]] headsUpScreen:leftScreen]];
	right = [[HeadsUpWindowController alloc] initWithWindow:[[HeadsUpWindow alloc] initWithContentView:[[HeadsUpTextView alloc] initWithFrame:[rightScreen initialContentRect]] headsUpScreen:rightScreen]];
}

@end
