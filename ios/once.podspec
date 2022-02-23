#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint once.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'once'
  s.version          = '0.0.1'
  s.summary          = 'Want to run a piece of code once (Only - Week - Month - Year - Any duration)? We got you.'
  s.description      = <<-DESC
Want to run a piece of code once (Only - Week - Month - Year - Any duration)? We got you.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
