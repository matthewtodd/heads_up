#import "HeadsUpTextView.h"

@implementation HeadsUpTextView

- (id)init {
	// Start with a HUGE frame that won't resize with the parent view.
	// Our strategy is to squish the window around to properly position
	// the text on the screen.
	self = [super initWithFrame:NSMakeRect(0, 0, 10000, 10000)];
	
	if (self) {
		[self setAllowsUndo:FALSE];
//		[self setBackgroundColor: [NSColor clearColor]];
		[self setEditable:FALSE];
		[self setFieldEditor:FALSE];
		[self setFont:[NSFont fontWithName:@"Menlo" size:12.0]];
		[self setHorizontallyResizable:FALSE];
		[self setSelectable:FALSE];
//		[self setTextColor:[[NSColor whiteColor] colorWithAlphaComponent:0.5]];
		[self setVerticallyResizable:FALSE];
		
		[[self textContainer] setHeightTracksTextView:FALSE];
		[[self textContainer] setWidthTracksTextView:FALSE];
	}
	
	return self;
}

- (void)setString:(NSString *)string {
	[super setString:string];
}

- (NSRect) usedTextRectangle {
	// Trigger a layout; without this, we just get 0,0 for dimensions!?
	[[self layoutManager] glyphRangeForTextContainer:[self textContainer]];
	
	return [[self layoutManager] usedRectForTextContainer:[self textContainer]];
}

@end