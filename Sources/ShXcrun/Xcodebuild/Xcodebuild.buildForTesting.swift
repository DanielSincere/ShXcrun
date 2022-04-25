import Sh

extension Xcodebuild {

  /// Build the target and associated tests in the build root (SYMROOT).
  /// This will also produce an xctestrun file in the build root.
  /// This requires specifying a `scheme`.
  public func buildForTesting(_ sink: Sink = .terminal) throws {
    try sh(sink, serializedCommand(action: "build-for-testing"))
  }
}
