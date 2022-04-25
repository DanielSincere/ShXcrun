public protocol AltoolCredential {
  var serialized: String { get }
  var environment: [String: String] { get }
}

public extension AltoolCredential {
  var environment: [String: String] { [:] }
}
