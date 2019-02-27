//
//  DebugDetector.swift
//  SecurityDetector
//
//  Created by Steven Koposov on 2/25/19.
//  Copyright © 2019 Hyperion. All rights reserved.
//

import Foundation

typealias Completion = () -> Void

final class DebugDetector {
  
  static func detectDebug(completion: @escaping Completion) {
    _timer.setEventHandler(handler: {
      self.kernelInfo(completion: completion)
    })
    _timer.resume()
  }
  
}

fileprivate extension DebugDetector {
  
  //-----------------------------------------------------------------------------
  static var _timer: DispatchSourceTimer = {
    let queue = DispatchQueue.global(qos: .default)
    let timer = DispatchSource.makeTimerSource(queue: queue)
    timer.schedule(deadline: .now(), repeating: .seconds(1), leeway: .seconds(0))
    return timer
  }()
  
  //-----------------------------------------------------------------------------
  static func kernelInfo(completion: @escaping Completion) {
    
    let DBGCHK_P_TRACED: Int32 = 0x00000800 /* Debugged process being traced */
    var size: size_t = MemoryLayout<kinfo_proc>.size
    var procInfo: kinfo_proc = kinfo_proc()
    
    memset(&procInfo, 0, size)
    
    var name = [Int32](repeating: 0, count: 4)
    
    name[0] = CTL_KERN        // "high kernel": proc, limits
    name[1] = KERN_PROC       // process entries
    name[2] = KERN_PROC_PID   // by process id
    name[3] = getpid()        // returns the process ID (PID) of the calling process.
    
    let sys = kernelState(&name, nlen: 4, oldval: &procInfo, oldlenp: &size)
    guard case 0 = sys else { fatalError() }
    
    if procInfo.kp_proc.p_flag & DBGCHK_P_TRACED != 0 {
      _timer.cancel()
      completion()
    }
  }
  
  //-----------------------------------------------------------------------------
  /*
   name: - points to an array of integers: each of the integer values
   identifies a sysctl item, either a directory or a leaf node file.
   
   nlen: - states how many integer numbers are listed in the array name:
   to reach a particular entry you need to specify the path through the subdirectories,
   so you need to tell how long is such path.
   
   oldval: - is a pointer to a data buffer where the old value of the sysctl item must be stored.
   If it is NULL, the system call won't return values to user space.
   
   oldlenp: - points to an integer number stating the length of the oldval buffer.
   The system call changes the value to reflect how much data has been written,
   which can be less than the buffer length.
   */
  
  static func kernelState(_ name:UnsafeMutablePointer<Int32>!,
                          nlen:u_int,
                          oldval:UnsafeMutableRawPointer!,
                          oldlenp:UnsafeMutablePointer<Int>!) -> Int32 {
    /*
     +------------------------------------------------+
     |                TARGET_OS_MAC                   |
     | +---+  +-------------------------------------+ |
     | |   |  |          TARGET_OS_IPHONE           | |
     | |OSX|  | +-----+ +----+ +-------+ +--------+ | |
     | |   |  | | IOS | | TV | | WATCH | | BRIDGE | | |
     | |   |  | +-----+ +----+ +-------+ +--------+ | |
     | +---+  +-------------------------------------+ |
     +------------------------------------------------+
     
     The sysctl utility retrieves kernel state and allows processes
     with appropriate privilege to set kernel state.
     The state to be retrieved or set is described using a Management Information Base'' (MIB'')
     */
    
    #if os(iOS) && !targetEnvironment(simulator)
    // Assembly level interface to sysctl
    return readSys(name, nlen, oldval, oldlenp)
    #else
    //  C level interface to sysctl (lot of operation not permitted on real device)
    return sysctl(name, nlen, oldval, oldlenp, nil, 0)
    #endif
  }
}
