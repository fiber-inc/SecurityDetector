//
//  SecurityDetector.swift
//  SecurityDetector
//
//  Created by Steven Koposov on 2/27/19.
//  Copyright © 2019 Hyperion. All rights reserved.
//

import Foundation

public class SecurityDetector {
  
  //-----------------------------------------------------------------------------
  // Jailbreak Detector
  public static func isDeviceJailBroken() -> Bool {
    return JailBreakDetector.isJailBroken()
  }
  
  //-----------------------------------------------------------------------------
  // Debugging Detector
  public static func detectDebugging(completion: @escaping () -> Void) {
    DebugDetector.detectDebug(completion: completion)
  }
  
}
