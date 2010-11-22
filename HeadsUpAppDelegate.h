//
//  HeadsUpAppDelegate.h
//  HeadsUp
//
//  Created by Matthew Todd on 11/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HeadsUpWindowController.h"

@interface HeadsUpAppDelegate : NSObject <NSApplicationDelegate> {
	HeadsUpWindowController *left;
	HeadsUpWindowController *right;
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
