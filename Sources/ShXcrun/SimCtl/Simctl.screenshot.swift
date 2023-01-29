import Sh

extension Simctl {
  func screenshot(_ sink: Sink = .terminal, simulator name: String, path: String) throws {
    try sh(.terminal, "xcrun simctl io '\(name)' screenshot \(path) --type png --mask alpha")
  }
}
