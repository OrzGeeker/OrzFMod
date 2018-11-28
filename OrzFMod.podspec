Pod::Spec.new do |s|
  s.name         = "OrzFMod"
  s.version      = "0.0.1"
  s.summary      = "A Swift Capsule of FMod Audio Framework."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
  Use this Framework to power a Keygen Music Player
                   DESC

  s.homepage     = "https://github.com/OrzGeeker/OrzFMod"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author             = { "wangzhizhou" => "824219521@qq.com" }
  s.social_media_url   = "https://github.com/wangzhizhou"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/OrzGeeker/OrzFMod.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "OrzFMod/**/*.{h,hpp,m,mm}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "OrzFMod/OrzFMod.h", "OrzFMod/FModCapsule/FModCapsule.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "OrzFMod/Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  s.frameworks = "UIKit", "AudioToolbox", "AVFoundation"
  s.vendored_libraries = "OrzFMod/**/*.{a}"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
