#import "Position.h"

@implementation Position

- (id)initWithIsLeft:(BOOL)yesOrNo {
	self = [super init];
	if (self) {
		isLeft = yesOrNo;
		margin = 12;
	}
	return self;
}

+ (id)bottomLeft {
	return [[self alloc] initWithIsLeft:TRUE];
}

+ (id)bottomRight {
	return [[self alloc] initWithIsLeft:FALSE];
}

- (CGFloat)x:(CGFloat)width {
	return isLeft ? margin : [[NSScreen mainScreen] frame].size.width - width - margin;
}

- (CGFloat)y:(CGFloat)height {
	return margin;
}

- (NSRect)windowFrame {
	return [self windowFrameWithSize:NSMakeSize(100,100)];
}

- (NSRect)windowFrameWithSize:(NSSize)size {
	int x = [self x:size.width];
	int y = [self y:size.height];
	return NSMakeRect(x, y, size.width, size.height);
}

@end
