@class Command, Window;

@interface HeadsUpAppDelegate : NSObject {
	Command *leftCommand;
	Command *rightCommand;
	Window *leftWindow;
	Window *rightWindow;

	NSStatusItem *item;
	NSMenu *menu;
    NSWindow *window;
}

@property (assign) IBOutlet NSMenu *menu;
@property (assign) IBOutlet NSWindow *window;

@end
