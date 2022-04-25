import Sh

extension Xcodebuild {
  /// Build the target in the build root (SYMROOT).
  public func build(_ sink: Sink = .terminal) throws {
    try sh(sink, serializedCommand(action: "build"))
  }
}
