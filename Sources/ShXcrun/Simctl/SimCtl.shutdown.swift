import Sh

extension SimCtl {
  
  /**
   Shutdown a device.
   */
  func shutdown(_ sink: Sink = .terminal, simulator name: String) throws {
    try sh(sink, "xcrun simctl shutdown '\(name)'")
  }
}
