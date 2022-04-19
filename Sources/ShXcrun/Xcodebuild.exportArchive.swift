import Sh

extension Xcodebuild {

  public func exportArchive(_ sink: Sink, archivePath: String, exportPath: String? = nil, exportOptionsPlistPath: String) throws {
    var buffer = "-archivePath \(archivePath) -exportOptionsPlist \(exportOptionsPlistPath)"
    if let exportPath = exportPath {
      buffer.append("-exportPath \(exportPath)")
    }
    buffer.append(" -exportArchive")
    try sh(sink, serializedCommand(action: buffer))
  }
}
