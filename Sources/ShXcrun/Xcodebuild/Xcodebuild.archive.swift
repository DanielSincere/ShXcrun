import Sh

extension Xcodebuild {
  /// Archive a scheme from the build root (SYMROOT).
  /// This requires specifying a `scheme`.
  public func archive(_ sink: Sink = .terminal, path: String) throws {
    try sh(sink, serializedCommand(action: "-archivePath \(path) archive"))
  }
}
