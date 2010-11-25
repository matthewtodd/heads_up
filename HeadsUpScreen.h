@interface HeadsUpScreen : NSObject {
	NSString *key;
	NSString *contents;
}

@property (readonly) NSString *contents;

- (id)initWithKey:(NSString *)key;
- (void)runCommand:(NSNotification *)notification;

@end

extern NSString * const HeadsUpScreenDidUpdateNotification;