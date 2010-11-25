#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreen.h"
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
	leftScreen = [[HeadsUpScreen alloc] initWithKey:@"bottom_left"];
	[NSTimer scheduledTimerWithTimeInterval:60 target:leftScreen selector:@selector(runCommand:) userInfo:nil repeats:TRUE];
	leftWindow = [[HeadsUpWindow alloc] initWithPosition:[WindowPosition bottomLeft]];
	[leftWindow observeScreen:leftScreen];
	[[NSNotificationCenter defaultCenter] postNotificationName:HeadsUpScreenDidUpdateNotification object:leftScreen];
	[leftScreen runCommand:nil];
	[leftWindow orderFront:self];

	rightScreen = [[HeadsUpScreen alloc] initWithKey:@"bottom_right"];
	[NSTimer scheduledTimerWithTimeInterval:60 target:rightScreen selector:@selector(runCommand:) userInfo:nil repeats:TRUE];
	rightWindow = [[HeadsUpWindow alloc] initWithPosition:[WindowPosition bottomRight]];
	[rightWindow observeScreen:rightScreen];
	[[NSNotificationCenter defaultCenter] postNotificationName:HeadsUpScreenDidUpdateNotification object:rightScreen];
	[rightScreen runCommand:nil];
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
