#import "NSString+Trimming.h"

@implementation NSString ( Trimming )

// NSString already provides stringByTrimmingCharactersInSet:, but it trims both ends.
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)set {
	NSInteger i = [self length];
	while ([set characterIsMember:[self characterAtIndex:(i-1)]]) {
		i--;
	}
	return [self substringToIndex:i];
}

@end