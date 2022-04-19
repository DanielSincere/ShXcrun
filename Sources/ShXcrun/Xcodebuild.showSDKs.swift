import Sh

extension Xcodebuild {

  public func showSDKs() throws -> [SDK] {
    try sh([SDK].self, serializedCommand(action: "-showsdks -json"))
  }

  public struct SDK: Decodable {
    public let buildID: String?
    public let canonicalName: String
    public let displayName: String
    public let isBaseSdk: Bool
    public let platform: String
    public let platformPath: String
    public let platformVersion: String
    public let productBuildVersion: String?
    public let productCopyright: String?
    public let productVersion: String?
    public let sdkPath: String
    public let sdkVersion: String
  }
}

/*
 {
   "canonicalName" : "driverkit21.4",
   "displayName" : "DriverKit 21.4",
   "isBaseSdk" : true,
   "platform" : "driverkit",
   "platformPath" : "/Applications/Xcode.app/Contents/Developer/Platforms/DriverKit.platform",
   "platformVersion" : "21.4",
   "sdkPath" : "/Applications/Xcode.app/Contents/Developer/Platforms/DriverKit.platform/Developer/SDKs/DriverKit21.4.sdk",
   "sdkVersion" : "21.4"
 },
 */

/*
 "buildID" : "1D3EED0A-9484-11EC-8202-FD9470514C11",
 "canonicalName" : "iphoneos15.4",
 "displayName" : "iOS 15.4",
 "isBaseSdk" : true,
 "platform" : "iphoneos",
 "platformPath" : "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform",
 "platformVersion" : "15.4",
 "productBuildVersion" : "19E239",
 "productCopyright" : "1983-2022 Apple Inc.",
 "productName" : "iPhone OS",
 "productVersion" : "15.4",
 "sdkPath" : "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.4.sdk",
 "sdkVersion" : "15.4"
 */
