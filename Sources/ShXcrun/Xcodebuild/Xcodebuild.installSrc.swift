import Sh

extension Xcodebuild {
  /// Copy the source of the project to the source root (SRCROOT).
  public func installSrc(_ sink: Sink) throws {
    try sh(sink, serializedCommand(action: "installsrc"))
  }
}
