#
# Be sure to run `pod lib lint MultiRowUITabBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MultiRowUITabBar'
  s.version          = '0.1.0'
  s.summary          = 'A Sub Class of UITabCarController to show more Tab Bar items in multiple rows'

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/MultiRowUITabBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dodda Srinivasan' => 'srinivasan.munna@gmail.com' }
  s.source           = { :git => 'https://github.com/DoddaSrinivasan/MultiRowUITabBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MultiRowUITabBar/Classes/**/*'

  s.resource_bundles = {
    'MultiRowUITabBar' => ['MultiRowUITabBar/Assets/DSMenu.xib', 'MultiRowUITabBar/Assets/DSMenuItem.xib']
  }
end
