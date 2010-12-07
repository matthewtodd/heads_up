#import "ContentSizedTextView.h"

@implementation ContentSizedTextView

- (id)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];

	if (self) {
		NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
		[style setDefaultTabInterval:28.0];
		[style setTabStops:[NSArray array]];

		[self setAllowsUndo:FALSE];
		[self setBackgroundColor: [NSColor clearColor]];
		[self setDefaultParagraphStyle:style];
		[self setEditable:FALSE];
		[self setFieldEditor:FALSE];
		[self setFont:[NSFont fontWithName:@"Menlo" size:12.0]];
		[self setHorizontallyResizable:FALSE];
		[self setSelectable:FALSE];
		[self setTextColor:[[NSColor whiteColor] colorWithAlphaComponent:0.5]];
		[self setVerticallyResizable:FALSE];

		[[self textContainer] setHeightTracksTextView:FALSE];
		[[self textContainer] setWidthTracksTextView:FALSE];
	}

	return self;
}

- (NSSize)textSize {
	// Trigger a layout, otherwise we just get 0,0 for dimensions!?
	[[self layoutManager] glyphRangeForTextContainer:[self textContainer]];
	return [[self layoutManager] usedRectForTextContainer:[self textContainer]].size;	
}

@end
