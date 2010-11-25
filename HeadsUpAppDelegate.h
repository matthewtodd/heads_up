#import "Command.h"
#import "HeadsUpWindow.h"

// Though it doesn't appear this way when reading AppKit/NSApplication.h, it
// seems the formal NSApplicationDelegate protocol was only introduced in the
// 10.6 SDK: http://stackoverflow.com/questions/1496788
//
#if (MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_5)
@interface HeadsUpAppDelegate : NSObject {
#else
@interface HeadsUpAppDelegate : NSObject <NSApplicationDelegate> {
#endif
	Command *leftCommand;
	Command *rightCommand;
	HeadsUpWindow *leftWindow;
	HeadsUpWindow *rightWindow;
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
