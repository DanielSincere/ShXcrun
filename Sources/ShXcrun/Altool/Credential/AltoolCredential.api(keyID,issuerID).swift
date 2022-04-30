extension AltoolCredential where Self == ApiKeyCredential {
  public static func api(keyID: String, issuerID: String) -> Self {
    Self(apiKeyID: keyID, apiIssuerID: issuerID)
  }
}

public struct ApiKeyCredential: AltoolCredential {

  let apiKeyID: String
  let apiIssuerID: String

  public var serialized: String {
    "--apiKey \(apiKeyID) --apiIssuer \(apiIssuerID)"
  }
}
