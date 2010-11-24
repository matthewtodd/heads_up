#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreen.h"

@implementation HeadsUpAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	left  = [[HeadsUpWindowController alloc] initWithScreen:[[HeadsUpScreen alloc] initWithKey:@"bottom_left"]];
	right = [[HeadsUpWindowController alloc] initWithScreen:[[HeadsUpScreen alloc] initWithKey:@"bottom_right"]];
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification {
	[left runCommand:notification];
	[right runCommand:notification];
}

@end
