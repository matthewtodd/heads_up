//
//  HeadsUpWindowController.m
//  HeadsUp
//
//  Created by Matthew Todd on 11/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HeadsUpWindowController.h"


@implementation HeadsUpWindowController

- (id)initWithWindow:(NSWindow *)window screen:(id <HeadsUpScreen>)screen {
	self = [super initWithWindow:window];

	if (self) {
//		[self setScreen:screen];

		[[self window] orderFront:self];
	}

	return self;
}

@end
