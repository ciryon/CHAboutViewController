Pod::Spec.new do |s|
  s.name         = "CHAboutViewController"
  s.version      = "0.0.1"
  s.summary      = "A simple and easy to use view controller that will display your app name, versions and allow user to visit your webpage or provide feedback."
  s.homepage     = "http://github.com/ciryon/CHAboutViewController"
  s.license      = 'MIT'
  s.author       = { "Christian Hedin" => "ciryon@mac.com" }
  s.source       = { :git => "https://github.com/ciryon/CHAboutViewController.git", :tag => "0.0.1" }
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source_files = 'CHAboutViewController/**/*.{h,m}'
  s.framework  = 'MessageUI'
  s.requires_arc = true
end
