import Sh

extension Xcodebuild {
  public func test(_ sink: Sink = .terminal) throws {
    try sh(sink, serializedCommand(action: "test"))
  }
}
