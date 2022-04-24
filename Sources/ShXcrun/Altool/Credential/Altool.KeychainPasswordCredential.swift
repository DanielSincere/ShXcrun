extension AltoolCredential where Self == KeychainPasswordCredential {
  public static func password(username: String? = nil, keychain: String) -> Self {
    Self(username: username, keychain: keychain)
  }
}

public struct KeychainPasswordCredential: AltoolCredential {
  
  let username: String?
  let keychain: String
  
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
