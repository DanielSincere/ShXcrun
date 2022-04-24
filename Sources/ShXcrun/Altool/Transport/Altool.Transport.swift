extension Altool {
  public enum Transport: String {
    case signiant = "Signiant"
    case aspera = "Aspera"
    case dav = "DAV"
    case https = "HTTPS"
  }
}

extension Optional where Wrapped == Array<Altool.Transport> {
  var serialized: String {
    switch self {
    case .none:
      return ""
    case .some(let wrapped):
      return wrapped.serialized
    }
  }
}

extension Array where Element == Altool.Transport {
  var serialized: String {
    guard !isEmpty else {
      return ""
    }
    
    return "--transport " + self
      .map { $0.rawValue }
      .joined(separator: ", ")
  }
}
