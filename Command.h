@interface Command : NSObject {
	NSString *key;
	NSString *output;
}

@property (copy) NSString *key;
@property (copy) NSString *output;

- (id)initWithKey:(NSString *)key;
- (void)runCommand:(NSNotification *)notification;

@end