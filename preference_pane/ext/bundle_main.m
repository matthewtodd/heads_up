#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <RubyCocoa/RubyCocoa.h>
#import <PreferencePanes/PreferencePanes.h>

@interface HeadsUpPreferencePaneLoader : NSObject
{}
@end
@implementation HeadsUpPreferencePaneLoader
@end

static void __attribute__((constructor)) loadRubyPrefPane(void)
{
	RBBundleInit("HeadsUpPreferencePane.rb", [HeadsUpPreferencePaneLoader class], nil);
}