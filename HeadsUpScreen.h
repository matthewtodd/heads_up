// TODO rename to (Window)Position
@interface HeadsUpScreen : NSObject {
	NSString *key;
}

- (id)initWithKey:(NSString *)key;
- (void)runCommandAndNotify:(id)observer selector:(SEL)selector;
- (NSRect)windowFrameWithSize:(NSSize)size;

@end