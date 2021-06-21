Pod::Spec.new do |s|
  s.name         = "OrzFMod"
  s.version      = "0.0.4"
  s.summary      = "A Swift Capsule of FMod Audio Framework."
  s.description  = <<-DESC
  Use this Framework to power a Keygen Music Player
                   DESC
  s.homepage     = "https://github.com/OrzGeeker/OrzFMod"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author             = { "wangzhizhou" => "824219521@qq.com" }
  s.social_media_url   = "https://github.com/wangzhizhou"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/OrzGeeker/OrzFMod.git", :tag => "#{s.version}" }
  s.source_files  = "OrzFMod/**/*.{h,hpp,m,mm}"
  s.public_header_files = "OrzFMod/OrzFMod.h", "OrzFMod/FModCapsule/FModCapsule.h"
  s.resources = "OrzFMod/**/*.{png,xm}"
  s.frameworks = "UIKit", "AudioToolbox", "AVFoundation"
  s.vendored_libraries = "OrzFMod/**/*.{a}"
end
