#import "HeadsUpTextView.h"

@implementation HeadsUpTextView

- (id)init {
	self = [super initWithFrame:NSMakeRect(12, 12, 500, 100)];
	
	if (self) {
		[self setAllowsUndo:FALSE];
		[self setBackgroundColor: [NSColor clearColor]];
		[self setEditable:FALSE];
		[self setFieldEditor:FALSE];
		[self setFont: [NSFont fontWithName:@"Menlo" size:12.0]];
		[self setHorizontallyResizable:FALSE];
		[self setSelectable:FALSE];
		[self setString:@"Hello, World!"];
		[self setTextColor: [[NSColor whiteColor] colorWithAlphaComponent:0.5]];
		[self setVerticallyResizable:FALSE];
		
		[[self textContainer] setHeightTracksTextView:FALSE];
		[[self textContainer] setWidthTracksTextView:FALSE];
	}
	
	return self;
}

@end