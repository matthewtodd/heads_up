@class Command, Window;

@interface HeadsUpAppDelegate : NSObject {
	Command *leftCommand;
	Command *rightCommand;
	Window *leftWindow;
	Window *rightWindow;

	NSStatusItem *item;
	NSMenu *menu;
}

@property (assign) IBOutlet NSMenu *menu;

@end
