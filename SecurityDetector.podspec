Pod::Spec.new do |s|
 # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "SecurityDetector"
  s.version      = "0.0.1"
  s.summary      = "Debugging/Jailbreak Detectors."
  s.description  = <<-DESC
  A much much longer description of SecurityDetector.
                   DESC
  s.homepage      = "http://EXAMPLE/SecurityDetector"
  s.module_name   = 'SecurityDetector'  

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "Copyleft"
  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author       = { "Steven" => "stepan.koposov@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "10.0"
  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'
  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => 'https://github.com/Steven-koposov/SecurityDetector.git' }
  # s.source       = { :git => "https://github/samwize/CryptoCoreData", :tag => "#{s.version}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = 'SecurityDetector', 'SecurityDetector/*.swift', 'SecurityDetector/Detectors/*.swift', 'SecurityDetector/Detectors/asm*.{h,a}'
  s.public_header_files = "SecurityDetector", "SecurityDetector/SecurityDetector/*.h"
  

  # s.preserve_paths = '*.a'
  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

   # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.frameworks    = 'Foundation'

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  # s.xcconfig = { 'SWIFT_OBJC_BRIDGING_HEADER' => 'SecurityDetector/SecurityDetector/*.h' }

end