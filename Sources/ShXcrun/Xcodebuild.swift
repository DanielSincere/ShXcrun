import Sh
import Foundation

public final class Xcodebuild {

  let workspace: String?
  let scheme: String?
  let destination: DestinationSpecifier?
  let configuraton: String?
  let arch: [String]?
  let sdk: String?

  let showBuildTimingSummary: Bool

  public init(workspace: String? = nil,
              scheme: String? = nil,
              destination: DestinationSpecifier? = nil,
              configuraton: String? = nil,
              arch: [String]? = nil,
              sdk: String? = nil,
              showBuildTimingSummary: Bool = false) {
    self.workspace = workspace
    self.scheme = scheme
    self.destination = destination
    self.configuraton = configuraton
    self.arch = arch
    self.sdk = sdk
    self.showBuildTimingSummary = showBuildTimingSummary
  }

  func serializedCommand(action: String) -> String {
    var buffer = "xcrun xcodebuild"

    if let workspace = workspace {
      buffer.append(" -workspace \(workspace)")
    }

    if let scheme = scheme {
      buffer.append(" -scheme \(scheme)")
    }

    if let destination = destination {
      buffer.append(" -destination \(destination)")
    }

    if let arch = arch {
      for arch in arch {
        buffer.append(" -arch \(arch)")
      }
    }

    if showBuildTimingSummary {
      buffer.append(" -showBuildTimingSummary")
    }

    buffer.append(" \(action)")

    return buffer
  }
}
