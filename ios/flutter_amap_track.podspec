#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_amap_track.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_amap_track'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin for AMap Track Service.'
  s.description      = <<-DESC
A new Flutter plugin for AMap Track Service.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AMapTrack'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.static_framework = true
  s.swift_version = '5.0'
end
