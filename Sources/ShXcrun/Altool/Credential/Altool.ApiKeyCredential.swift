extension AltoolCredential where Self == ApiKeyCredential {
  public static func api(key: String, issuerID: String) -> Self {
    Self(apiKey: key, apiIssuerID: issuerID)
  }
}

public struct ApiKeyCredential: AltoolCredential {
  
  let apiKey: String
  let apiIssuerID: String
  
  public var serialized: String {
    "--apiKey \(apiKey) --apiIssuer \(apiIssuerID)"
  }
}
