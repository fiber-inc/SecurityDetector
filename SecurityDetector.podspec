Pod::Spec.new do |s|
 # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "SecurityDetector"
  s.version      = "1.0.2"
  s.summary      = "Debugging/Jailbreak Detectors."
  s.description  = <<-DESC
    Security Detector provide jailbreak detection and debug attach detection.
                   DESC
  s.homepage     = "https://github.com/fiber-inc/SecurityDetector"
  s.module_name  = 'SecurityDetector'  

  # ―――  Spec License & Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT license"  
  s.author       = { "Steven" => "stepan.koposov@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform              = :ios, "10.0"
  s.ios.deployment_target = '10.0'
  s.swift_version         = '4.2'
  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source              = { :git => 'https://github.com/fiber-inc/SecurityDetector' }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files        = 'SecurityDetector', 'SecurityDetector/*.swift', 'SecurityDetector/Detectors/*.swift', 'SecurityDetector/ASM/*.{h,s}'
  s.public_header_files = "SecurityDetector", "SecurityDetector/SecurityDetector/*.h"
  
  # ――― Frameworks ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.frameworks    = 'Foundation'

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.pod_target_xcconfig = {'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/SecurityDetector/**','LIBRARY_SEARCH_PATHS' => '$(SRCROOT)/SecurityDetector/'}
  s.preserve_paths  = 'SecurityDetector/module.modulemap'
end