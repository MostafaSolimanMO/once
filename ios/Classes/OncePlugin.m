#import "OncePlugin.h"
#if __has_include(<once/once-Swift.h>)
#import <once/once-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "once-Swift.h"
#endif

@implementation OncePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOncePlugin registerWithRegistrar:registrar];
}
@end
