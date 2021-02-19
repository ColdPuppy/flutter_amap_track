#import "FlutterAmapTrackPlugin.h"
#if __has_include(<flutter_amap_track/flutter_amap_track-Swift.h>)
#import <flutter_amap_track/flutter_amap_track-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_amap_track-Swift.h"
#endif

@implementation FlutterAmapTrackPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAmapTrackPlugin registerWithRegistrar:registrar];
}
@end
