Pod::Spec.new do |s|
  s.name         = "CircularPickerView"
  s.module_name  = "AppusCircularPickerView"
  s.version      = "0.0.3"
  s.summary      = "CircularPickerView very simple picker which allow you to select value within certain limits"
  s.homepage     = "http://appus.pro"
  s.license      = { :type => "Apache", :file => 'LICENSE' }
  s.author       = { "Alexey Kubas" => "alexey.kubas@appus.me" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/alexey-kubas-appus/Circular-PickerView.git", :tag => "0.0.3" }
  s.source_files = "CircularPickerView/*.swift"
  s.frameworks   = 'Foundation', 'UIKit', 'QuartzCore'
  s.requires_arc = true
end
