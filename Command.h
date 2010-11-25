@interface Command : NSObject {
	NSString *key;
	NSString *output;
	NSTimer  *timer;
}

@property (copy) NSString *output;

- (id)initWithKey:(NSString *)key;

@end