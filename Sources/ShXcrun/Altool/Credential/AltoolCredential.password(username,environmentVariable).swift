extension AltoolCredential where Self == EnvironmentVariablePasswordCredential {
  public static func password(username: String, environmentVariable: String) -> Self {
    Self(username: username, environmentVariable: environmentVariable)
  }
}

public struct EnvironmentVariablePasswordCredential: AltoolCredential {
  
  let username: String
  let environmentVariable: String
  
  public var serialized: String {
    "-u \(username) -p @env:\(environmentVariable)"
  }
}
