#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreenLeft.h"
#import "HeadsUpScreenRight.h"
#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	left  = [[HeadsUpWindowController alloc] initWithWindow:[[HeadsUpWindow alloc] initWithContentView:[[HeadsUpTextView alloc] init] screen:[[HeadsUpScreenLeft alloc] init]]];
	right = [[HeadsUpWindowController alloc] initWithWindow:[[HeadsUpWindow alloc] initWithContentView:[[HeadsUpTextView alloc] init] screen:[[HeadsUpScreenRight alloc] init]]];
}

@end
