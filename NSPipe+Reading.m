#import "NSPipe+Reading.h"

@implementation NSPipe ( Reading )

// TODO retain the string?
- (NSString *)readStringToEndOfFileWithEncoding:(NSStringEncoding)encoding {
	return [[NSString alloc] initWithData:[[self fileHandleForReading] readDataToEndOfFile] encoding:encoding];
}

@end
