#import <Cocoa/Cocoa.h>
#import <RubyCocoa/RBRuntime.h>

@interface HeadsUpPreferencePaneLoader : NSObject
{}
@end
@implementation HeadsUpPreferencePaneLoader
@end

static void __attribute__((constructor)) loadRubyPrefPane(void)
{
	RBBundleInit("HeadsUpPreferencePane.rb", [HeadsUpPreferencePaneLoader class], nil);
}