// TODO rename to (Window)Position
@interface HeadsUpScreen : NSObject {
	NSString *key;
	NSString *contents;
}

@property (readonly) NSString *contents;

- (id)initWithKey:(NSString *)key;
- (void)runCommand;
- (NSRect)windowFrameWithSize:(NSSize)size;

@end

extern NSString * const HeadsUpScreenDidUpdateNotification;