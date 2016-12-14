Pod::Spec.new do |s|
  s.name         = "CircularPickerView"
  s.module_name  = "AppusCircularPickerView"
  s.version      = "0.1.0"
  s.summary      = "CircularPickerView very simple picker which allow you to select value within certain limits"
  s.homepage     = "http://appus.pro"
  s.license      = { :type => "Apache", :file => 'LICENSE' }
  s.author       = { "Alexey Kubas" => "alexey.kubas@appus.me" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/alexey-kubas-appus/Circular-PickerView.git", :tag => s.version.to_s }
  s.source_files = "CircularPickerView/*.swift"
  s.frameworks   = 'Foundation', 'UIKit', 'QuartzCore'
  s.requires_arc = true
end
