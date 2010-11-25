#import "HeadsUpAppDelegate.h"
#import "Command.h"
#import "WindowPosition.h"

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
	leftCommand = [[Command alloc] initWithKey:@"bottom_left"];
	leftWindow = [[HeadsUpWindow alloc] initWithPosition:[WindowPosition bottomLeft] observing:leftCommand];
	[leftCommand runCommand:nil];
	[leftWindow orderFront:self];

	rightCommand = [[Command alloc] initWithKey:@"bottom_right"];
	rightWindow = [[HeadsUpWindow alloc] initWithPosition:[WindowPosition bottomRight] observing:rightCommand];
	[rightCommand runCommand:nil];
	[rightWindow orderFront:self];
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification {
	[leftWindow reposition];
	[rightWindow reposition];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
	[window makeKeyAndOrderFront:self];
}

@end
