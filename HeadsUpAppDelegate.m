#import "Command.h"
#import "HeadsUpAppDelegate.h"
#import "Position.h"
#import "Window.h"

@implementation HeadsUpAppDelegate

@synthesize window;

- (void)registerDefaultCommands {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	if (![[defaults persistentDomainNames] containsObject:[[NSBundle mainBundle] bundleIdentifier]]) {
		[defaults setValue:@"ruby -retc -e 'name = Etc.getpwnam(Etc.getlogin).gecos; first = name.split(/\\s/).first; puts \"Welcome to HeadsUp, #{first}!\"'" forKey:@"bottom_left"];
		[defaults setValue:@"echo \"Now, blow away these settings and run whatever you like...\\n- Commands refresh every minute: $(date)\\n- PATH=$PATH\"" forKey:@"bottom_right"];
	}
}

- (void)createStatusItem {
	item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
	[item setTitle:@"#!"];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self registerDefaultCommands];
	[self createStatusItem];

	leftCommand  = [[Command alloc] initWithKey:@"bottom_left"];
	rightCommand = [[Command alloc] initWithKey:@"bottom_right"];

	leftWindow  = [[Window alloc] initWithPosition:[Position bottomLeft] observing:leftCommand];
	rightWindow = [[Window alloc] initWithPosition:[Position bottomRight] observing:rightCommand];
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification {
	[leftWindow reposition];
	[rightWindow reposition];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
	[window makeKeyAndOrderFront:self];
}

@end
