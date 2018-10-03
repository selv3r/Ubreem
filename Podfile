# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Ubream-iOS' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Ubream-iOS
   pod 'Alamofire'
   pod 'NVActivityIndicatorView'
   pod 'CFAlertViewController'
   pod 'SwiftyJSON'
   pod 'BRYXBanner'
   pod 'Kingfisher', '~> 4.0'
   pod 'Material'
   pod 'Popover'
   pod 'DGActivityIndicatorView'
   pod 'Cosmos', '~> 12.0'
   pod 'SnapKit'
   pod 'IQKeyboardManagerSwift'
   pod 'Lightbox'

end


# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
