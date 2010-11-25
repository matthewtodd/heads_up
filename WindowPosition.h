@interface WindowPosition : NSObject {
	BOOL isLeft;
	CGFloat margin;
}

+ (id)bottomLeft;
+ (id)bottomRight;

- (NSRect)windowFrameWithSize:(NSSize)size;

@end
