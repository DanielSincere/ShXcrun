import Sh

extension Altool {
  
  public func uploadApp(_ sink: Sink, file: String, platform: Platform, transport: [Transport]? = nil) throws {
    try sh(sink, serializedCommand("--upload-app -f \(file) -t \(platform) \(transport.serialized)"))
  }
}
