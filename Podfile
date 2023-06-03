# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'scrum' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

pod 'Parse'
pod 'FSCalendar'

  # Pods for scrum


  post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No' 
	  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
     end
  end
end
