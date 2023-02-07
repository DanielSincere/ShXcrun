public struct EnvironmentVariablePasswordCredential: AltoolCredential {
  
  let username: String
  let environmentVariable: String
  
  public init(username: String, environmentVariable: String) {
    self.username = username
    self.environmentVariable = environmentVariable
  }
  
  public var serialized: String {
    "-u \(username) -p @env:\(environmentVariable)"
  }
}
