import Sh

public final class Altool {
  let credential: AltoolCredential
  public init(credential: AltoolCredential) {
    self.credential = credential
  }
  
  func serializedCommand(_ text: String) -> String {
    "xcrun altool \(credential.serialized) \(text)"
  }
}
