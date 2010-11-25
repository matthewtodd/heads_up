@class Command, WindowPosition;

@interface HeadsUpWindow : NSWindow {
	WindowPosition *position;
}

@property WindowPosition *position;

- (id)initWithPosition:(WindowPosition *)position observing:(Command *)command;
- (void)reposition;

@end