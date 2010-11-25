@class Command, WindowPosition;

@interface Window : NSWindow {
	WindowPosition *position;
}

@property WindowPosition *position;

- (id)initWithPosition:(WindowPosition *)position observing:(Command *)command;
- (void)reposition;

@end