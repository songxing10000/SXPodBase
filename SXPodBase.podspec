#
# Be sure to run `pod lib lint SXPodBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
#pod名称
  s.name             = 'SXPodBase'
#pod版本
  s.version          = '0.0.3'
#简介，需要更改，不然会报警告
  s.summary          = 'SXPodBase personal development of the project and the accumulation of open source projects'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
#详细介绍，要比简介长
  s.description      = <<-DESC
                        SXPodBase personal development of the project and the accumulation of open source projects 
                       DESC
# 项目主页
  s.homepage         = 'https://github.com/songxing10000/SXPodBase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
#协议
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
# 开发者信息
  s.author           = { 'dfpo' => 'songxing10000@live.cn' }
#仓库地址
  s.source           = { :git => 'https://github.com/songxing10000/SXPodBase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
# 最低版本
  s.ios.deployment_target = '8.0'
# 库文件
  s.source_files = 'SXPodBase/Classes/**/*'
#资源目录
  s.resource_bundles = {
     'SXPodBase' => ['SXPodBase/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
#依赖的framework
  # s.frameworks = 'UIKit', 'MapKit'
# 依赖的第三方库
  s.dependency 'YYModel'
  s.dependency 'Masonry'
  s.dependency 'MJRefresh'
  s.dependency 'MBProgressHUD'
  s.dependency 'DZNEmptyDataSet'
end
