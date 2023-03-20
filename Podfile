source 'https://cdn.cocoapods.org/'
platform :ios, '16.0'
use_frameworks!
inhibit_all_warnings!

install! 'cocoapods', :warn_for_unused_master_specs_repo => false

def pods_common
  pod 'Alamofire'
  pod 'SwiftLint'
end

target 'presentation-project' do
  pods_common

  target 'presentation-projectTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
    end
  end
end
