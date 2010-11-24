#import <Cocoa/Cocoa.h>

@interface NSPipe ( Reading )
- (NSString *)readStringToEndOfFileWithEncoding:(NSStringEncoding)encoding;
@end
