#import <Cocoa/Cocoa.h>

@interface HeadsUpTextView : NSTextView {
}

- (void)setString:(NSString *)string;
- (NSRect)usedRectForText;
@end