Pod::Spec.new do |s|
  s.name             = 'LayaKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of LayaKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MF-dosear/LayaKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dosear' => 'dosear@qq.com' }
  s.source           = { :git => 'https://github.com/MF-dosear/LayaKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  
  s.frameworks  = 'CoreMotion','OpenAL','JavaScriptCore','Foundation'
  
  s.libraries = 'bz2.1.0'
  
  s.source_files = ['LayaKit/Classes/**/*','LayaKit/Libraries/include/*.h']
  
  s.public_header_files = ['LayaKit/Classes/**/*.h','LayaKit/Libraries/include/*.h']
  
  s.vendored_libraries = 'LayaKit/Libraries/conch/libconch.a'
  
  s.resources = ['LayaKit/Libraries/libconchRuntime.bundle']
  
#  s.frameworks  = 'Foundation','CoreTelephony','CoreGraphics','SystemConfiguration','Security','AdSupport','Security','AVFoundation','AudioToolbox','JavaScriptCore','OpenGLES','OpenAL','UIKit','GLKit','CoreMotion','SafariServices','MessageUI','CoreMedia','Accelerate','CFNetwork','iAd','CoreFoundation','UserNotifications','AppTrackingTransparency','WebKit'
#
#  s.libraries = 'z','sqlite3','sqlite3.0','iconv','icucore','resolv','c++','c++abi','bz2.1.0'
  
#  s.vendored_frameworks = 'LayaKit/Frameworks/**/*.framework'

#  s.source_files = ['LayaKit/Classes/**/*','LayaKit/Resource/**/*.h']
#  
#  s.public_header_files = ['LayaKit/Classes/**/*.h','LayaKit/Resource/**/*.h']
#  
#  s.vendored_libraries = 'LayaKit/Resource/libs/libconch.a'
  
#  s.resources = ['LayaKit/Resource/*.json']
  
#   s.resource_bundles = {
#     'LayaKit' => ['LayaKit/Assets/*.png']
#   }

   
#   s.frameworks = 'UIKit', 'MapKit'
#   s.dependency 'AFNetworking', '~> 2.3'
  
  
end
