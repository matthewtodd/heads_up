#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreen.h"

@implementation HeadsUpAppDelegate

@synthesize window;

// TODO set up some default commands?
//
// Not as simple as it would seem, because values passed to
// NSUserDefaults.registerDefaults are returned when the keys
// have been set back to nil, as they are when the user clears
// out one of the boxes in the preferences window. So, I need
// some way to register the defaults only if they've never
// been registered before... weird.
//
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	left  = [[HeadsUpWindowController alloc] initWithScreen:[[HeadsUpScreen alloc] initWithKey:@"bottom_left"]];
	right = [[HeadsUpWindowController alloc] initWithScreen:[[HeadsUpScreen alloc] initWithKey:@"bottom_right"]];
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification {
	[left runCommand:notification];
	[right runCommand:notification];
}

@end
