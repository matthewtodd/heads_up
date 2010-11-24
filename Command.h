@interface Command : NSObject {
	NSString *string;
}

- (id)initWithString:(NSString *)string;
- (void)runAndNotify:(id)observer selector:(SEL)selector;

@end