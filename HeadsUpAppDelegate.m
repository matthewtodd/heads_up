#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreenLeft.h"
#import "HeadsUpScreenRight.h"

@implementation HeadsUpAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	left  = [[HeadsUpWindowController alloc] initWithHeadsUpScreen:[[HeadsUpScreenLeft alloc] init]];
	right = [[HeadsUpWindowController alloc] initWithHeadsUpScreen:[[HeadsUpScreenRight alloc] init]];
}

@end
