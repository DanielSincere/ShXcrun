import Sh

extension SimCtl {

  public struct Runtime: Decodable {
//    "bundlePath" : "\/Applications\/Xcode.app\/Contents\/Developer\/Platforms\/iPhoneOS.platform\/Library\/Developer\/CoreSimulator\/Profiles\/Runtimes\/iOS.simruntime",
//    "buildversion" : "20B72",
//    "platform" : "iOS",
//    "runtimeRoot" : "\/Applications\/Xcode.app\/Contents\/Developer\/Platforms\/iPhoneOS.platform\/Library\/Developer\/CoreSimulator\/Profiles\/Runtimes\/iOS.simruntime\/Contents\/Resources\/RuntimeRoot",
//    "identifier" : "com.apple.CoreSimulator.SimRuntime.iOS-16-1",
//    "version" : "16.1",
//    "isInternal" : false,
//    "isAvailable" : true,
//    "name" : "iOS 16.1",
  }
  public static func listRuntimes() -> [Runtime] {
   []
  }
  
  struct Runtimes: Decodable {
    let runtimes: [Runtime]
  }
}
