import Sh

extension Xcodebuild {
  public func test(_ sink: Sink) throws {
    try sh(sink, serializedCommand(action: "test"))
  }
}
