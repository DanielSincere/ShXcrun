extension AltoolCredential where Self == LiteralPasswordCredential {
  public static func password(username: String, password: String) -> Self {
    Self(username: username, password: password)
  }
}

public struct LiteralPasswordCredential: AltoolCredential {

  let username: String
  let password: String
  
  public var serialized: String {
    "-u \(username) -p @env:SH_XCRUN_ALTOOL_PASSWORD"
  }
  
  public var environment: [String : String] {
    ["SH_XCRUN_ALTOOL_PASSWORD": password]
  }
}
