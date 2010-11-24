#import "HeadsUpWindowController.h"

@interface HeadsUpAppDelegate : NSObject <NSApplicationDelegate> {
	HeadsUpWindowController *left;
	HeadsUpWindowController *right;
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
