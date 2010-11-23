#import "HeadsUpScreen.h"

@interface HeadsUpWindow : NSWindow {
	id <HeadsUpScreen> headsUpScreen;
}

@property (assign) id <HeadsUpScreen> headsUpScreen;

- (id)initWithHeadsUpScreen:(id <HeadsUpScreen>)theHeadsUpScreen;
- (void)setString:(NSString *)string;

@end