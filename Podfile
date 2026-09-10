source 'https://cdn.cocoapods.org/'

platform :ios, '15.0'

use_frameworks!
inhibit_all_warnings!


abstract_target 'TastyTomatoAbstract' do
    pod 'SignificantSpices', '~> 0.15.11'
    pod 'SwiftDate', '~> 6.3.1'

    target 'TastyTomato'
    target 'TastyTomatoTests'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "15.0"
    end
  end
end
