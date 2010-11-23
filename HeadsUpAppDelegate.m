#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreenLeft.h"
#import "HeadsUpScreenRight.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	left  = [[HeadsUpWindowController alloc] initWithHeadsUpWindow:[[HeadsUpWindow alloc] initWithHeadsUpScreen:[[HeadsUpScreenLeft alloc] init]]];
	right = [[HeadsUpWindowController alloc] initWithHeadsUpWindow:[[HeadsUpWindow alloc] initWithHeadsUpScreen:[[HeadsUpScreenRight alloc] init]]];
}

@end
