#
# Be sure to run `pod lib lint BNActionSheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BNActionSheet'
  s.version          = '1.0.5'
  s.summary          = 'A short description of BNActionSheet.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  "An action sheet with the same look as Apple's UIAlertController with actionSheet style. Provides the ability to add a custom header at the top."
                       DESC

  s.homepage         = 'https://github.com/botirjon/BNActionSheet'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'botirjon' => 'botirjon.nasridinov@gmail.com' }
  s.source           = { :git => 'https://github.com/botirjon/BNActionSheet.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'BNActionSheet/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BNActionSheet' => ['BNActionSheet/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
