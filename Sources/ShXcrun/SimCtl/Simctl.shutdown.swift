import Sh

extension Simctl {
  
  /**
   Shutdown a device.
   */
  public func shutdown(_ sink: Sink = .terminal) throws {
    try sh(sink, "xcrun simctl shutdown '\(name)'")
  }
}
