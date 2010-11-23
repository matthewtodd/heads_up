#import <Cocoa/Cocoa.h>

@interface HeadsUpTextView : NSTextView {
}

- (void)setString:(NSString *)string;
- (NSSize)textSize;

@end