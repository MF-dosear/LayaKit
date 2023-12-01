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

  s.source_files = 'LayaKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LayaKit' => ['LayaKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
