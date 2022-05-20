import Sh
import Foundation

extension Altool {

  public func uploadApp(_ sink: Sink = .terminal, file: String, platform: Platform, transport: [Transport]? = nil) throws {
   
    var buffer = "xcrun altool \(credential.serialized) --upload-app -f \(file) -t \(platform)"
    
    if let transport = transport {
      buffer.append(transport.serialized)
    }
    
    try sh(sink,
           buffer,
           environment: self.credential.environment)
  }
}
