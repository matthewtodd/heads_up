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

- (id)initWithContentRect:(NSRect)contentRect {
	self = [super initWithContentRect:contentRect
							styleMask:NSBorderlessWindowMask
							  backing:NSBackingStoreBuffered
								defer:FALSE];
	if (self) {
		[self setAutodisplay:TRUE];
		[self setBackgroundColor: [NSColor clearColor]];
		[self setHasShadow:FALSE];
		[self setIgnoresMouseEvents:TRUE];
		[self setLevel:CGWindowLevelForKey(kCGDesktopWindowLevelKey)];
		[self setOpaque:FALSE];
		[self setReleasedWhenClosed:TRUE];
		
		[self setContentView: [[HeadsUpTextView alloc] initWithFrame:[[self contentView] frame]]];
	}
	
	return self;
}

@end
