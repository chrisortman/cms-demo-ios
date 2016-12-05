# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

target 'CmsDemo' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for CmsDemo
  pod 'couchbase-lite-ios', '~> 1.3.1'
  pod 'ResearchKit', :git => 'https://github.com/chrisortman/ResearchKit.git', :branch => 'mcvrs'
  pod 'PKHUD'
  pod "Unbox"
  pod "Wrap"
  pod "SteviaLayout"

  target "UnitTests" do
    inherit! :search_paths

    pod 'Quick'
    pod 'Nimble'
  end
end
