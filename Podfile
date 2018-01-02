# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def networking_pods
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'SwiftyBeaver'
end

def ux_design
    pod 'SnapKit'
    pod 'IQKeyboardManager'
    pod 'TTTAttributedLabel'
    pod 'Lightbox', '~> 2.0.0'
    pod 'SwiftValidator', :git => "https://github.com/milomi/SwiftValidator.git", :commit => '96061eca93f5016681679fbb2af84949c1e11d19'
    pod 'PKHUD'
    pod 'GTProgressBar'
end

def rxSwift
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxRealm'
end

target 'OSOM_app' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OSOM_app
  networking_pods
  ux_design
  rxSwift

  target 'OSOM_appTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OSOM_appUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
