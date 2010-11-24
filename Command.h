@interface Command : NSObject {
	NSString *string;
	id observer;
	SEL selector;
}

- (id)initWithString:(NSString *)string;
- (void)runAndNotify:(id)observer selector:(SEL)selector;

@end