public struct LiteralPasswordCredential: AltoolCredential {

  let username: String
  let password: String
  
  public init(username: String, password: String) {
    self.username = username
    self.password = password
  }
  
  public var serialized: String {
    "-u \(username) -p @env:SH_XCRUN_ALTOOL_PASSWORD"
  }
  
  public var environment: [String : String] {
    ["SH_XCRUN_ALTOOL_PASSWORD": password]
  }
}
