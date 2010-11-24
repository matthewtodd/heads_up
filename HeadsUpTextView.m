#import "HeadsUpTextView.h"
#import "NSString+Trimming.h"

@implementation HeadsUpTextView

// TODO set up tab stops, as in RubyCocoa HeadsUp.
- (id)init {
	// Start with a HUGE frame that won't resize with the parent view.
	// Our strategy is to squish the window around to properly position
	// the text on the screen.
	self = [super initWithFrame:NSMakeRect(0, 0, 10000, 10000)];
	
	if (self) {
		[self setAllowsUndo:FALSE];
		[self setBackgroundColor: [NSColor clearColor]];
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

- (void)setString:(NSString *)string {
	[super setString:[string stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (NSSize) textSize {
	// TODO pull this into a private method
	// Trigger a layout; without this, we just get 0,0 for dimensions!?
	[[self layoutManager] glyphRangeForTextContainer:[self textContainer]];
	
	return [[self layoutManager] usedRectForTextContainer:[self textContainer]].size;
}

@end