# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for FinderThingy
  source 'https://github.com/CocoaPods/Specs.git'

target 'FinderThingy' do
  
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'Alamofire', '~> 4.4’

  target 'FinderThingyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FinderThingyUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end
