import Sh

extension Simctl {
  
  /**
   Erase a device.
   */
  public func erase(_ sink: Sink = .terminal) throws {
    try sh(sink, "xcrun simctl erase '\(name)'")
  }
}
