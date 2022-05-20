import Sh
import Foundation

extension Altool {

  public func uploadApp(_ sink: Sink = .terminal, file: String, platform: Platform, transport: [Transport]? = nil) throws {
    
    let cred = credential.serialized
    let trans = transport.serialized
    try sh(sink,
           "xcrun altool \(cred) --upload-app -f \(file) -t \(platform) \(trans)",
           environment: self.credential.environment)
  }
}
