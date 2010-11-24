@interface Command : NSObject {
	NSString *string;
	id observer;
	SEL selector;
}

- (id)initWithString:(NSString *)string observer:(id)observer selector:(SEL)selector;
- (void)run;

@end