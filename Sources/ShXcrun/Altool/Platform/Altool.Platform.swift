extension Altool {
  
  public enum Platform: String, CustomStringConvertible {
    case macOS = "macos"
    case iOS = "ios"
    case tvOS = "appletvos"
    
    public var description: String { rawValue }
  }
}
