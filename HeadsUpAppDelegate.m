#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreenLeft.h"
#import "HeadsUpScreenRight.h"

@implementation HeadsUpAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	left  = [[HeadsUpWindowController alloc] initWithScreen:[[HeadsUpScreenLeft alloc] init]];
	right = [[HeadsUpWindowController alloc] initWithScreen:[[HeadsUpScreenRight alloc] init]];
}

@end
