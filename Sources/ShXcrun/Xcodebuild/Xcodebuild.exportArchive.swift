import Sh

extension Xcodebuild {

  public func exportArchive(_ sink: Sink = .terminal, archivePath: String, exportPath: String? = nil, exportOptionsPlistPath: String) throws {
    var buffer = "xcrun xcodebuild -exportArchive -archivePath \(archivePath) -exportOptionsPlist \(exportOptionsPlistPath)"
    
    if let exportPath = exportPath {
      buffer.append(" -exportPath \(exportPath)")
    }
    
    if allowProvisioningUpdates {
      buffer.append(" -allowProvisioningUpdates")
    }
    
    if allowProvisioningDeviceRegistration {
      buffer.append(" -allowProvisioningDeviceRegistration")
    }
    
    try sh(sink, buffer)
  }
}
