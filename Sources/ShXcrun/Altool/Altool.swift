import Sh

public final class Altool {
  let credential: AltoolCredential
  public init(credential: AltoolCredential) {
    self.credential = credential
  }
  
  func stem() -> String {
    "xcrun altool \(credential.serialized)"
  }
}
