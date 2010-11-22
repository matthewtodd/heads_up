//
//  HeadsUpWindow.m
//  HeadsUp
//
//  Created by Matthew Todd on 11/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"


@implementation HeadsUpWindow

- (id)initWithContentView:(NSView *)contentView {
	self = [super initWithContentRect:NSMakeRect(0,0,100,100) styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:FALSE];

	if (self) {
		[self setAutodisplay:TRUE];
		[self setBackgroundColor: [NSColor clearColor]];
		[self setContentView:contentView];
		[self setHasShadow:FALSE];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];
		[self setReleasedWhenClosed:TRUE];
	}
	
	return self;
}

@end
