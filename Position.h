@interface Position : NSObject {
	BOOL isLeft;
	CGFloat margin;
}

+ (id)bottomLeft;
+ (id)bottomRight;

- (NSRect)windowFrame;
- (NSRect)windowFrameWithSize:(NSSize)size;

@end
