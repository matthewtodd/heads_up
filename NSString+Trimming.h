#import <Cocoa/Cocoa.h>

// NSString already provides stringByTrimmingCharactersInSet:, but it trims both ends.
@interface NSString ( Trimming )
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)set;
@end
