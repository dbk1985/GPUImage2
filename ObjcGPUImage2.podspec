#
#  Be sure to run `pod spec lint GPUImage2.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "ObjcGPUImage2"
  s.version      = "0.1.2"
  s.summary      = "An open source iOS framework for GPU-based image and video processing."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
  GPUImage2 is an open source iOS framework in swift for GPU-based image and video processing, Building GPUImage2 for ios when you use Object-c to develop. If you want to inherit the class of GPUImage2, you must write you code with swift. The most effective approach for migrating code to Swift is on a per-file basis—that is, one class at a time. Because you can’t subclass Swift classes in Objective-C, it’s best to choose a class in your app that doesn’t have any subclasses. reference：https://developer.apple.com/documentation/swift/migrating_your_objective-c_code_to_swift#//apple_ref/doc/uid/TP40014216-CH12-XID_67
                   DESC

  s.homepage     = "https://github.com/BradLarson/GPUImage2"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "BSD"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "dbk1985" => "376958755@qq.com" }
  # Or just: s.author    = "dbk1985"
  # s.authors            = { "dbk1985" => "376958755@qq.com" }
  # s.social_media_url   = "http://twitter.com/dbk1985"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
    s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.swift_version = '4.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/dbk1985/GPUImage2.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "framework/Source/**/*.{swift}"
  # s.exclude_files = "Classes/Exclude"
  s.ios.exclude_files = 'framework/Source/Mac', 'framework/Source/Linux', 'framework/Source/Operations/Shaders/ConvertedShaders_GL.swift', 'framework/Source/OperationGroup.swift', 'framework/Source/BasicOperation.swift', 'framework/Source/ImageOrientation.swift', 'framework/Source/ImageGenerator.swift', 'framework/Source/iOS/*Input.swift', 'framework/Source/iOS/*Output.swift','framework/Source/Objc/ColorMatrixFilter.swift','framework/Source/Objc/ContrastAdjustment.swift','framework/Source/Objc/ExposureAdjustment.swift','framework/Source/Objc/FalseColor.swift','framework/Source/Objc/GammaAdjustment.swift','framework/Source/Objc/Haze.swift','framework/Source/Objc/HighlightAndShadowTint.swift','framework/Source/Objc/HighlightsAndShadows.swift','framework/Source/Objc/HueAdjustment.swift','framework/Source/Objc/LevelsAdjustment.swift','framework/Source/Objc/LookupFilter.swift','framework/Source/Objc/LuminanceRangeReduction.swift','framework/Source/Objc/LuminanceThreshold.swift','framework/Source/Objc/MonochromeFilter.swift','framework/Source/Objc/OpacityAdjustment.swift','framework/Source/Objc/RGBAdjustmentFilter.swift','framework/Source/Objc/SaturationAdjustment.swift','framework/Source/Objc/Vibrance.swift','framework/Source/Objc/WhiteBalance.swift','framework/Source/Objc/AverageLuminanceExtractor.swift','framework/Source/Objc/AverageLuminanceThreshold.swift','framework/Source/Objc/BrightnessAdjustment.swift','framework/Source/Objc/AverageColorExtractor.swift','framework/Source/Objc/LowPassFilter.swift','framework/Source/Objc/MotionDetector.swift','framework/Source/Objc/OpeningFilter.swift','framework/Source/Objc/PrewittEdgeDetection.swift','framework/Source/Objc/SingleComponentGaussianBlur.swift','framework/Source/Objc/SobelEdgeDetection.swift','framework/Source/Objc/ThresholdSobelEdgeDetection.swift','framework/Source/Objc/TransformOperation.swift','framework/Source/Objc/UnsharpMask.swift','framework/Source/Objc/AdaptiveThreshold.swift','framework/Source/Objc/BilateralBlur.swift','framework/Source/Objc/BoxBlur.swift','framework/Source/Objc/CannyEdgeDetection.swift','framework/Source/Objc/ChromaKeying.swift','framework/Source/Objc/ClosingFilter.swift','framework/Source/Objc/ColourFASTFeatureDetection.swift','framework/Source/Objc/Convolution3x3.swift','framework/Source/Objc/Crop.swift','framework/Source/Objc/Dilation.swift','framework/Source/Objc/Erosion.swift','framework/Source/Objc/GaussianBlur.swift','framework/Source/Objc/HarrisCornerDetector.swift','framework/Source/Objc/HighPassFilter.swift','framework/Source/Objc/Histogram.swift','framework/Source/Objc/HistogramEqualization.swift','framework/Source/Objc/ImageBuffer.swift','framework/Source/Objc/iOSBlur.swift','framework/Source/Objc/KuwaharaFilter.swift','framework/Source/Objc/MotionBlur.swift','framework/Source/Objc/PinchDistortion.swift','framework/Source/Objc/Pixellate.swift','framework/Source/Objc/PolarPixellate.swift','framework/Source/Objc/PolkaDot.swift','framework/Source/Objc/Posterize.swift','framework/Source/Objc/Sharpen.swift','framework/Source/Objc/SketchFilter.swift','framework/Source/Objc/SmoothToonFilter.swift','framework/Source/Objc/Solarize.swift','framework/Source/Objc/SphereRefraction.swift','framework/Source/Objc/StretchDistortion.swift','framework/Source/Objc/SwirlDistortion.swift','framework/Source/Objc/ThresholdSketch.swift','framework/Source/Objc/TiltShift.swift','framework/Source/Objc/ToonFilter.swift','framework/Source/Objc/Vignette.swift','framework/Source/Objc/ZoomBlur.swift','framework/Source/Objc/BulgeDistortion.swift','framework/Source/Objc/Crosshatch.swift','framework/Source/Objc/EmbossFilter.swift','framework/Source/Objc/GlassSphereRefraction.swift','framework/Source/Objc/Halftone.swift','framework/Source/Objc/AlphaBlend.swift','framework/Source/Objc/ChromaKeyBlend.swift','framework/Source/Objc/DissolveBlend.swift'

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  s.resources = 'framework/Source/Operations/Shaders/*.{fsh}'

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  s.frameworks   = ['OpenGLES', 'CoreMedia', 'QuartzCore', 'AVFoundation']

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.xcconfig = { 
  				'CLANG_MODULES_AUTOLINK' => 'YES',
                 'OTHER_SWIFT_FLAGS' => "$(inherited) -DGLES"
                 }
  # s.dependency "JSONKit", "~> 1.4"

end
