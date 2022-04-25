import Sh

extension Xcodebuild {
  /// Test compiled bundles. If a `scheme` is provided then
  /// the command finds bundles in the build root (SRCROOT).
  /// If an xctestrun file is provided then the command finds
  /// bundles at paths specified in the xctestrun file.
  public func testWithoutBuilding(_ sink: Sink = .terminal, xctestrun: String? = nil) throws {
    if let xctestrun = xctestrun {
      try sh(sink, serializedCommand(action: "-xctestrun \(xctestrun) test-without-building"))
    } else {
      try sh(sink, serializedCommand(action: "test-without-building"))
    }
  }
}
