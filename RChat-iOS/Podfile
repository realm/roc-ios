# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


post_install do |installer|
    # Your list of targets here.
    myTargets = ['Eureka']
    
    installer.pods_project.targets.each do |target|
        if myTargets.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end

target 'RChat' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RChat
  pod 'Chatto'
  pod 'ChattoAdditions'
  pod 'RealmSwift'
  pod 'SideMenu', '~> 2.1.3'
  pod 'SDWebImage', '~> 3.8.2'
  pod 'Eureka'
  pod 'Cartography', '1.0.1'
  pod 'TURecipientBar', '~> 2.0.4'
  pod 'NVActivityIndicatorView', '3.3'
  pod 'BRYXBanner', '~> 0.7.1'
  pod 'RealmLoginKit'

  
  target 'RChatTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RChatUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
