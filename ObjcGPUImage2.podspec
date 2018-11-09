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
  s.version      = "0.1.0"
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
  s.ios.exclude_files = 'framework/Source/Mac', 'framework/Source/Linux', 'framework/Source/Operations/Shaders/ConvertedShaders_GL.swift', 'framework/Source/OperationGroup.swift', 'framework/Source/BasicOperation.swift', 'framework/Source/ImageOrientation.swift', 'framework/Source/ImageGenerator.swift', 'framework/Source/iOS/*Input.swift', 'framework/Source/iOS/*Output.swift','framework/Source/Operations/ColorMatrixFilter.swift','framework/Source/Operations/ContrastAdjustment.swift','framework/Source/Operations/ExposureAdjustment.swift','framework/Source/Operations/FalseColor.swift','framework/Source/Operations/GammaAdjustment.swift','framework/Source/Operations/Haze.swift','framework/Source/Operations/HighlightAndShadowTint.swift','framework/Source/Operations/HighlightsAndShadows.swift','framework/Source/Operations/HueAdjustment.swift','framework/Source/Operations/LevelsAdjustment.swift','framework/Source/Operations/LookupFilter.swift','framework/Source/Operations/LuminanceRangeReduction.swift','framework/Source/Operations/LuminanceThreshold.swift','framework/Source/Operations/MonochromeFilter.swift','framework/Source/Operations/OpacityAdjustment.swift','framework/Source/Operations/RGBAdjustmentFilter.swift','framework/Source/Operations/SaturationAdjustment.swift','framework/Source/Operations/Vibrance.swift','framework/Source/Operations/WhiteBalance.swift','framework/Source/Operations/AverageLuminanceExtractor.swift','framework/Source/Operations/AverageLuminanceThreshold.swift','framework/Source/Operations/BrightnessAdjustment.swift','framework/Source/Operations/AverageColorExtractor.swift','framework/Source/Operations/LowPassFilter.swift','framework/Source/Operations/MotionDetector.swift','framework/Source/Operations/OpeningFilter.swift','framework/Source/Operations/PrewittEdgeDetection.swift','framework/Source/Operations/SingleComponentGaussianBlur.swift','framework/Source/Operations/SobelEdgeDetection.swift','framework/Source/Operations/ThresholdSobelEdgeDetection.swift','framework/Source/Operations/TransformOperation.swift','framework/Source/Operations/UnsharpMask.swift','framework/Source/Operations/AdaptiveThreshold.swift','framework/Source/Operations/BilateralBlur.swift','framework/Source/Operations/BoxBlur.swift','framework/Source/Operations/CannyEdgeDetection.swift','framework/Source/Operations/ChromaKeying.swift','framework/Source/Operations/ClosingFilter.swift','framework/Source/Operations/ColourFASTFeatureDetection.swift','framework/Source/Operations/Convolution3x3.swift','framework/Source/Operations/Crop.swift','framework/Source/Operations/Dilation.swift','framework/Source/Operations/Erosion.swift','framework/Source/Operations/GaussianBlur.swift','framework/Source/Operations/HarrisCornerDetector.swift','framework/Source/Operations/HighPassFilter.swift','framework/Source/Operations/Histogram.swift','framework/Source/Operations/HistogramEqualization.swift','framework/Source/Operations/ImageBuffer.swift','framework/Source/Operations/iOSBlur.swift','framework/Source/Operations/KuwaharaFilter.swift','framework/Source/Operations/MotionBlur.swift','framework/Source/Operations/PinchDistortion.swift','framework/Source/Operations/Pixellate.swift','framework/Source/Operations/PolarPixellate.swift','framework/Source/Operations/PolkaDot.swift','framework/Source/Operations/Posterize.swift','framework/Source/Operations/Sharpen.swift','framework/Source/Operations/SketchFilter.swift','framework/Source/Operations/SmoothToonFilter.swift','framework/Source/Operations/Solarize.swift','framework/Source/Operations/SphereRefraction.swift','framework/Source/Operations/StretchDistortion.swift','framework/Source/Operations/SwirlDistortion.swift','framework/Source/Operations/ThresholdSketch.swift','framework/Source/Operations/TiltShift.swift','framework/Source/Operations/ToonFilter.swift','framework/Source/Operations/Vignette.swift','framework/Source/Operations/ZoomBlur.swift','framework/Source/Operations/BulgeDistortion.swift','framework/Source/Operations/Crosshatch.swift','framework/Source/Operations/EmbossFilter.swift','framework/Source/Operations/GlassSphereRefraction.swift','framework/Source/Operations/Halftone.swift','framework/Source/Operations/AlphaBlend.swift','framework/Source/Operations/ChromaKeyBlend.swift','framework/Source/Operations/DissolveBlend.swift'
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
