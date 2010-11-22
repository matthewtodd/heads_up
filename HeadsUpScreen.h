#import <Cocoa/Cocoa.h>

@protocol HeadsUpScreen
- (NSRect)initialContentRect;
- (NSRect)windowFrameForTextRect:(NSRect)textRect;
@end