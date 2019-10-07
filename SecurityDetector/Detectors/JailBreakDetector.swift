//
//  JailBreakDetector.swift
//  SecurityDetector
//
//  Created by Steven Koposov on 2/22/19.
//  Copyright © 2019 Hyperion. All rights reserved.
//

import Foundation
import UIKit


final class JailBreakDetector {
  
  static func isJailBroken() -> Bool {
    #if !(TARGET_IPHONE_SIMULATOR)
    return detectFiles() || detectSchemes() || canSpoofing() || detectFork()
    #else
    return false
    #endif
  }
  
}


fileprivate struct System {
  
  static let files = [
    "/bin/sh",
    "/etc/apt",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/ssh/sshd_config",
    "/usr/libexec/ssh-keysign",
    "/private/var/stash",
    "/private/var/lib/apt/",
    "/private/var/lib/cydia",
    "/private/var/cache/apt/",
    "/private/var/log/syslog",
    "/private/var/tmp/cydia.log",
    "/Applications/Icy.app",
    "/Applications/Cydia.app",
    "/Applications/MxTube.app",
    "/Applications/RockApp.app",
    "/Applications/blackra1n.app",
    "/Applications/SBSettings.app",
    "/Applications/FakeCarrier.app",
    "/Applications/WinterBoard.app",
    "/Applications/IntelliScreen.app",
    "/private/var/mobile/Library/SBSettings/Themes",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
    "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
    "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
    "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist"
  ]
  
  static let links = ["/Library/Ringtones",
                      "/Library/Wallpaper",
                      "/Applications",
                      "/usr/include",
                      "/usr/libexec",
                      "/usr/share",
                      ]
  
  static let schemes = ["cydia://package/com.example.package"]
  
  static let jailbreakTextFile = "/private/jailbreak.txt"
  
}


fileprivate extension JailBreakDetector {
  
  //-----------------------------------------------------------------------------
  static func detectFiles() -> Bool {
    var existsPath = false
    for path: String in System.files {
      
      if FileManager.default.fileExists(atPath: path) {
        existsPath = true
        break
      }
      
    }
    return existsPath
  }
  
  //-----------------------------------------------------------------------------
  static func detectSchemes() -> Bool {
    var canOpenScheme = false
    for scheme: String in System.schemes {
      if let url = URL(string: scheme) {
        if UIApplication.shared.canOpenURL(url) {
          canOpenScheme = true
          break
        }
      }
    }
    return canOpenScheme
  }
  
  //-----------------------------------------------------------------------------
  static func canSpoofing() -> Bool {
    let spoofString = "Anti-spoofing detection."
    var grantsToWrite = false
    do {
      try spoofString.write(toFile: System.jailbreakTextFile, atomically: true, encoding: .utf8)
      grantsToWrite = true
    } catch {
      print("Device is not jailbroken")
    }
    try? FileManager.default.removeItem(atPath: System.jailbreakTextFile)
    return grantsToWrite
  }
  
  //-----------------------------------------------------------------------------
  static func detectFork() -> Bool {
    // The symbol lookup happens in the normal global scope
    // Special pseudo-handle for finding the first occurrence of the desired symbol
    // using the default library search order
    var canCreateFork = false
    let RTLD_DEFAULT = UnsafeMutableRawPointer(bitPattern: -2)
    let forkPtr = dlsym(RTLD_DEFAULT, "fork")
    typealias ForkType = @convention(c) () -> Int32
    let fork = unsafeBitCast(forkPtr, to: ForkType.self)
    let child: __darwin_pid_t = fork()
    let pid = Int(child)
    
    /*
     After initializing pid to -1 and status to 0.
     For jailbroken device pid value is greater than 0 whereas for non jailbroken device pid value remains unchanged.
     */
    
    precondition(pid != 0,"\n[🔥 ERROR]: ----- Incorrect Child Fork Behavior For iOS : \(self)" )
    if pid > 0  { canCreateFork = true }
    return canCreateFork
  }
  
}
