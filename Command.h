@interface Command : NSObject {
	NSString *key;
	NSString *contents;
}

@property (copy) NSString *key;
@property (copy) NSString *contents;

- (id)initWithKey:(NSString *)key;
- (void)runCommand:(NSNotification *)notification;

@end