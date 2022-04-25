import Sh

extension Xcodebuild {
  /// Build and analyze a target or scheme from the build root (SYMROOT).
  /// This requires specifying a `scheme`.
  public func analyze(_ sink: Sink = .terminal) throws {
    try sh(sink, serializedCommand(action: "analyze"))
  }
}
