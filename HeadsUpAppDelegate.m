#import "Command.h"
#import "HeadsUpAppDelegate.h"
#import "Position.h"
#import "Window.h"

@implementation HeadsUpAppDelegate

@synthesize menu, preferences;

- (void)registerDefaultCommands {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	if (![[defaults persistentDomainNames] containsObject:[[NSBundle mainBundle] bundleIdentifier]]) {
		[defaults setValue:@"ruby -retc -e 'name = Etc.getpwnam(Etc.getlogin).gecos; first = name.split(/\\s/).first; puts \"Welcome to HeadsUp, #{first}!\"'" forKey:@"bottom_left"];
		[defaults setValue:@"echo \"Now, blow away these settings and run whatever you like...\\n- Commands refresh every minute: $(date)\\n- PATH=$PATH\"" forKey:@"bottom_right"];
	}
}

- (void)createStatusItem {
	item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
	[item setTitle:@"✓"];
	[item setHighlightMode:TRUE];
	[item setMenu:menu];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self registerDefaultCommands];
	[self createStatusItem];

	leftCommand  = [[Command alloc] initWithKey:@"bottom_left"];
	rightCommand = [[Command alloc] initWithKey:@"bottom_right"];

	leftWindow  = [[Window alloc] initWithPosition:[Position bottomLeft]];
	[[leftWindow contentView] bind:@"string" toObject:leftCommand withKeyPath:@"output" options:nil];

	rightWindow = [[Window alloc] initWithPosition:[Position bottomRight]];
	[[rightWindow contentView] bind:@"string" toObject:rightCommand withKeyPath:@"output" options:nil];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
	[self showPreferences:self];
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification {
	[leftWindow reposition];
	[rightWindow reposition];
}

- (NSString *)marketingVersion {
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (IBAction)showPreferences:(id)sender {
	[[NSApplication sharedApplication] activateIgnoringOtherApps:TRUE];
	[preferences makeKeyAndOrderFront:sender];
}

@end
