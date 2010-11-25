@class Command, Position;

@interface Window : NSWindow {
	Position *position;
}

- (id)initWithPosition:(Position *)position observing:(Command *)command;
- (void)reposition;

@end