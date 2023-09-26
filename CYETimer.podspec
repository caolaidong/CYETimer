
Pod::Spec.new do |spec|


  spec.name         = "CYETimer"
  spec.version      = "1.0.0"
  spec.summary      = "定时器 DispatchSource Timer."
  spec.homepage     = "https://github.com/caolaidong/CYETimer"
  spec.author       = "caolaidong"
  spec.license      = "MIT"
  spec.source       = { :git => "https://github.com/caolaidong/CYETimer.git", :tag => '1.0.0'}
  spec.ios.deployment_target = "15.0"
  spec.source_files  = "CYETimer.swift"
  spec.framework  = "SystemConfiguration"
  spec.swift_versions = ['5.0']


end
