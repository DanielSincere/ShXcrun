public struct KeychainPasswordCredential: AltoolCredential {
  
  let username: String?
  let keychain: String
  
  public init(username: String?, keychain: String) {
    self.username = username
    self.keychain = keychain
  }
  
  public var serialized: String {
    "\(usernameIfPresent) -p @keychain:\(keychain)"
  }
  
  private var usernameIfPresent: String {
    switch username {
    case .some(let username): return "-u \(username)"
    case .none: return ""
    }
  }
}
