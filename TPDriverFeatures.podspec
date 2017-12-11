
Pod::Spec.new do |s|

  s.name         = "TPDriverFeatures"
  s.version      = "0.0.1"
  s.summary      = "TPProject 的功能模块库"

  s.description  = <<-DESC
                   使用该库用来引用driver相关的功能模块
                   DESC

  s.homepage     = "https://github.com/FlyFishBoys/TPProjectFeature"
  s.license      = "MIT"
  s.author             = { "FlyFishBoys" => "2517185883@qq.com" }
  
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/FlyFishBoys/TPProjectFeature.git", :tag => s.version }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  =  "TestDemo/TestDemo/**/*.{h,m}"

 #s.source_files  = "Classes", "Classes/**/*.{h,m}"
 #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

#s.ios.vendored_frameworks = "TestDemo/Pods/AMap2DMap/MAMapKit.framework"



  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
   s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
   s.dependency 'AFNetworking'
   s.dependency 'Masonry'      
   s.dependency 'AMap2DMap' , '~> 4.6.0'
   s.dependency 'MBProgressHUD' 
   s.dependency 'ProgressHUD' 
  #s.dependency 'AMap2DMap-NO-IDFA'
  #s.dependency 'AMapSearch-NO-IDFA'
  #s.dependency 'AMapLocation-NO-IDFA'



end
