#
# Be sure to run `pod lib lint TypeOutAnimationLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TypeOutAnimationLabel"
  s.version          = "0.1.0"
  s.summary          = "An UILabel with type out animation, inspired from https://connoratherton.com/typeout"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/buubui/TypeOutAnimationLabel"
  s.screenshots     = "https://cloud.githubusercontent.com/assets/5128246/14739286/cd08d298-08b0-11e6-8380-b1b81dc368ad.gif"
  s.license          = 'MIT'
  s.author           = { "Buu Bui" => "github.com/buubui" }
  s.source           = { :git => "https://github.com/buubui/TypeOutAnimationLabel.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TypeOutAnimationLabel/Classes/**/*'
  s.resource_bundles = {
    'TypeOutAnimationLabel' => ['TypeOutAnimationLabel/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
