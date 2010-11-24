#import "NSString+Predicates.h"

@implementation NSString ( Predicates )

- (BOOL)isPresent {
	return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0;
}

@end