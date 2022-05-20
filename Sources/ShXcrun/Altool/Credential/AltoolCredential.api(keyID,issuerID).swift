extension AltoolCredential where Self == ApiKeyCredential {
  public static func api(keyID: String, issuerID: String) -> Self {
    Self(apiKeyID: keyID, apiIssuerID: issuerID)
  }
}

public struct ApiKeyCredential: AltoolCredential {

  let apiKeyID: String
  let apiIssuerID: String

  public var serialized: String {
    "--apiKey $SH_XCRUN_ALTOOL_API_KEY_ID --apiIssuer $SH_XCRUN_ALTOOL_API_ISSUER_ID"
  }
  
  public var environment: [String: String] {
    [
      "SH_XCRUN_ALTOOL_API_KEY_ID": apiKeyID,
      "SH_XCRUN_ALTOOL_API_ISSUER_ID": apiIssuerID,
    ]
  }
}
