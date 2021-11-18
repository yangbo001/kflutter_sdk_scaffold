#import "KflutterSdkScaffoldPlugin.h"
#if __has_include(<kflutter_sdk_scaffold/kflutter_sdk_scaffold-Swift.h>)
#import <kflutter_sdk_scaffold/kflutter_sdk_scaffold-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "kflutter_sdk_scaffold-Swift.h"
#endif

@implementation KflutterSdkScaffoldPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKflutterSdkScaffoldPlugin registerWithRegistrar:registrar];
}
@end
