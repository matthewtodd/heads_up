@class Command, Position;

@interface Window : NSWindow {
	Position *position;
}

- (id)initWithPosition:(Position *)position;
- (void)reposition;

@end