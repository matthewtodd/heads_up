#import "HeadsUpScreen.h"

@interface HeadsUpWindow : NSWindow {
	id <HeadsUpScreen> headsUpScreen;
}

@property (assign) id <HeadsUpScreen> headsUpScreen;

- (id)initWithContentView:(NSView *)contentView headsUpScreen:(id <HeadsUpScreen>)theHeadsUpScreen;
- (HeadsUpTextView *)headsUpContentView;
- (void)setString:(NSString *)string;

@end