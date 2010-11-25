@interface Command : NSObject {
	NSString *key;
	NSString *output;
	NSTimer  *timer;
}

@property (copy) NSString *key;
@property (copy) NSString *output;
@property NSTimer *timer;

- (id)initWithKey:(NSString *)key;
- (void)trigger:(NSNotification *)notification;

@end