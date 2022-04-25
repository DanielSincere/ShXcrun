import Sh

extension Xcodebuild {

  /// Remove build products and intermediate files from
  /// the build root (SYMROOT).
  public func clean(_ sink: Sink = .terminal) throws {
    try sh(sink, serializedCommand(action: "clean"))
  }
}
