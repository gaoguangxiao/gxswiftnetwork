#
# Be sure to run `pod lib lint GXSwiftNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'GXSwiftNetwork'
    s.version          = '0.5.1'
    s.summary          = 'feat：适配最低13.0'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/gaoguangxiao'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '小修' => 'gaoguangxiao125@sina.com' }
    s.source           = { :git => 'https://github.com/gaoguangxiao/gxswiftnetwork.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '13.0'
    s.swift_versions = '5.0'
    
    # 基于Alamare网络请求 模块
    s.subspec 'MSB' do |e|
        e.source_files = 'GXSwiftNetwork/Classes/**/*'
    end
    
    # 基于苹果网络请求 模块
    s.subspec 'EvenSource' do |e|
        e.source_files = 'GXSwiftNetwork/Classes/EventSource/**/*'
    end
          
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'Moya'
    s.dependency 'SmartCodable'
    s.dependency 'GXPKHUD'
    
end
