import Sh

extension Simctl {
  
  public func screenshot(_ sink: Sink = .terminal,
                         path: String,
                         type: ScreenshotType = .png,
                         mask: ScreenshotMask? = nil,
                         display: ScreenshotDisplay? = nil) throws {
    
    var cmd = "xcrun simctl io '\(name)'"
    + " screenshot \(path)"
    + " --type \(type.rawValue)"
    if let mask {
      cmd += " --mask \(mask.rawValue)"
    }
    if let display {
      cmd += " --display \(display.rawValue)"
    }
    
    try sh(.terminal, cmd)
  }
  
  public enum ScreenshotType: String {
    case png, tiff, bmp, gif, jpeg
  }
  
  /// For non-rectangular displays, handle the mask by policy:
  public enum ScreenshotMask: String {
    
    case ignored /// The mask is ignored and the unmasked framebuffer is saved.
    case alpha /// The mask is used as premultiplied alpha.
    case black /// The mask is rendered black.
  }
  
  public enum ScreenshotDisplay: String {
    case `internal`, external
    /// iOS: supports "internal" or "external". Default is "internal".
    /// tvOS: supports only "external"
    /// watchOS: supports only "internal"
  }
}
