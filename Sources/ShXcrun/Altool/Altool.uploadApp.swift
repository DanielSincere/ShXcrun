import Sh
import Foundation

extension Altool {
    
  public func uploadApp(_ sink: Sink = .terminal, file: String, platform: Platform, transport: [Transport]? = nil) throws {
    let command =
    """
    xcrun altool \
    \(credential.serialized) \
    --upload-app \
    -f \(file) \
    -t \(platform) \
    \(transport.serialized)
    """
    
    try sh(sink, command,
           environment: self.credential.environment)
  }
}
