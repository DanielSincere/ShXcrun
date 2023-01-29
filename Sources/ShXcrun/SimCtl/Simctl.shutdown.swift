import Sh

extension Simctl {
  
  /**
   Shutdown a device.
   */
  func shutdown(_ sink: Sink = .terminal) throws {
    try sh(sink, "xcrun simctl shutdown '\(name)'")
  }
}
