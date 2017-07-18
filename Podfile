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
end

target 'OSOM_app' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OSOM_app
  networking_pods
  ux_design

  target 'OSOM_appTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OSOM_appUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
