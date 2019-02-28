# Hyperion Security Detector
iOS Jailbreak and Debugging Detector written in Swift

## Background
Security Detector provide jailbreak detection and debug attach detection.  

## Architecture:
* `"SecurityDetector.swift"` - encapsulates JailBreakDetector/DebugDetector and provide two simple methods for detection:
  `isDeviceJailBroken` and `detectDebugging`
* `"JailBreakDetector.swift"` - uses files/links/schemes/spoofing and fork() detection for Jailbreak. `isJailBroken` method for Jailbreak detection.
* `"DebugDetector.swift"` - uses The sysctl utility retrieves kernel state and allows processes
     with appropriate privilege to set kernel state.
     The state to be retrieved or set is described using a Management Information Base'' (MIB'').
     `detectDebug` method for debug attach detection.

## Requirements
- iOS 10.0+
- Xcode 10.1+
- Swift 4.2+   

## Installation

### CocoaPods

* If you don't already have CocoaPods installed, do `$ sudo gem install cocoapods` in your terminal. (See the [CocoaPods website]([https://cocoapods.org/)) for details.)
* In your project directory, do `pod init` to create a Podfile.
* Specify it in your `Podfile`: 
```ruby
    pod 'SecurityDetector', :git => 'https://github.com/Steven-koposov/SecurityDetector.git'
```
* Run `pod install`

### Manually
- Download a repo.
- Dag the `SecurityDetector.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `SecurityDetector.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `SecurityDetector.xcodeproj`  nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `SecurityDetector.framework`.

- Select the top SecurityDetector.framework for iOS.
- Go to your project’s root/setting file and find your way to the “Build Settings” tab. Use the search bar to find “Bitcode” and change the setting to NO. And that's it!

  > The `SecurityDetector.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

## Usage

That's very easy to use a SecurityDetector. Only write this few lines et voila!
```swift
    import SecurityDetector
```

```swift
    // jailbreak detection
    if SecurityDetector.isDeviceJailBroken() {
      print("Holy Moly, Houston we have a problem. Device is jailbroken!")
      missionImpossible()
    }
    // debugger detection
    SecurityDetector.detectDebugging {
      print("Holy Moly, Houston we have a problem. Debugger attached!")
      missionImpossible()
    }

    func missionImpossible() {
    // clear your cache data
    // clear your cookies
    // clear you CoreData context and connection
    // remove/clear your Network connection and removeAllCachedResponses
    // reset your UserDefaults and Keychain
    // quickly sell your digital currency :)
    // call the police :)
    // close app.  fatalError() :)
  }
```  

## License

SecurityDetector is released under the MIT license. [See LICENSE](https://github.com/Steven-koposov/SecurityDetector/blob/master/LICENSE) for details.

