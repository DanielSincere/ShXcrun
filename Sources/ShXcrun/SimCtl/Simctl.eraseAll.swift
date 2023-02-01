import Sh

extension Simctl {
  
  /**
   Erase all running devices
   */
  public static func eraseAll(_ sink: Sink = .terminal) throws {
    try sh(sink, "xcrun simctl erase all")
  }
}
