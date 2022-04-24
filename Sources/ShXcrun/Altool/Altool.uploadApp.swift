import Sh

extension Altool {
  
  public func uploadApp(_ sink: Sink, file: String, platform: Platform, transport: [Transport]? = nil) throws {
    var buffer = "--upload-app"
    buffer += " -f \(file)"
    buffer += " -t \(platform)"
    buffer += " \(transport.serialized)"
    try sh(sink, serialized(command: buffer))
  }
}
