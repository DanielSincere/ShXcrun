public struct ApiKeyCredential: AltoolCredential {

  let keyID: String
  let issuerID: String
  
  public init(keyID: String, issuerID: String) {
    self.keyID = keyID
    self.issuerID = issuerID
  }

  public var serialized: String {
    "--apiKey $SH_XCRUN_ALTOOL_API_KEY_ID --apiIssuer $SH_XCRUN_ALTOOL_API_ISSUER_ID"
  }
  
  public var environment: [String: String] {
    [
      "SH_XCRUN_ALTOOL_API_KEY_ID": keyID,
      "SH_XCRUN_ALTOOL_API_ISSUER_ID": issuerID,
    ]
  }
}
