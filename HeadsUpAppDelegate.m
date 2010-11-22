//
//  HeadsUpAppDelegate.m
//  HeadsUp
//
//  Created by Matthew Todd on 11/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HeadsUpAppDelegate.h"
#import "HeadsUpScreenLeft.h"
#import "HeadsUpScreenRight.h"
#import "HeadsUpTextView.h"
#import "HeadsUpWindow.h"

@implementation HeadsUpAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	id <HeadsUpScreen> screenLeft  = [[HeadsUpScreenLeft alloc] init];
	id <HeadsUpScreen> screenRight = [[HeadsUpScreenRight alloc] init];

	left  = [[HeadsUpWindowController alloc] initWithWindow:[[HeadsUpWindow alloc] initWithContentView:[[HeadsUpTextView alloc] init]] screen:screenLeft];
	right = [[HeadsUpWindowController alloc] initWithWindow:[[HeadsUpWindow alloc] initWithContentView:[[HeadsUpTextView alloc] init]] screen:screenRight];
}

@end
