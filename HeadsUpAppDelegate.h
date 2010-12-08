@class Command, Window;

@interface HeadsUpAppDelegate : NSObject {
	Command *leftCommand;
	Command *rightCommand;
	Window *leftWindow;
	Window *rightWindow;

	NSStatusItem *item;
	NSMenu *menu;
	NSWindow *preferences;
}

@property (readonly) NSString *marketingVersion;
@property (assign) IBOutlet NSMenu *menu;
@property (assign) IBOutlet NSWindow *preferences;

- (IBAction)showPreferences:(id)sender;

@end
