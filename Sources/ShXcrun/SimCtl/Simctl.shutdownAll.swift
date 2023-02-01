import Sh

extension Simctl {
  
  /**
   Shutdown all running devices
   */
  public static func shutdownAll(_ sink: Sink = .terminal) throws {
    try sh(sink, "xcrun simctl shutdown all")
  }
}
