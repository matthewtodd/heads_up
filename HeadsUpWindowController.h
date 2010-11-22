//
//  HeadsUpWindowController.h
//  HeadsUp
//
//  Created by Matthew Todd on 11/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HeadsUpScreen.h"

@interface HeadsUpWindowController : NSWindowController {
}

- (id)initWithWindow:(NSWindow *)window screen:(id <HeadsUpScreen>)screen;

@end
