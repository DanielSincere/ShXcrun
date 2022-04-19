import Foundation

public struct DestinationSpecifier: CustomStringConvertible, RawRepresentable {

  public let platform: Platform
  public let os: String?
  public let name: String?
  public let id: String?
  public let variant: String?

  public init(platform: Platform, os: String?, name: String?, id: String? = nil, variant: String? = nil) {
    self.platform = platform
    self.os = os
    self.name = name
    self.id = id
    self.variant = variant
  }

  public enum Platform: String {
    case iOSSimulator = "iOS Simulator"
    case iOS
    case macOS
    case watchOS
    case watchOSSimulator = "watchOS Simulator"
    case tvOS
    case tvOSSimulator = "tvOS Simulator"
  }

  public var description: String { rawValue }
  public var rawValue: String {
    var buffer = "platform='\(platform.rawValue)'"

    if let name = name {
      buffer.append(",name='\(name)'")
    }

    if let os = os {
      buffer.append(",OS='\(os)'")
    }

    if let id = id {
      buffer.append(",id=\(id)")
    }

    if let variant = variant {
      buffer.append(",variant='\(variant)'")
    }
    return buffer
  }

  public init?(rawValue: String) {
    do {
      try self.init(string: rawValue)
    } catch {
      print("couldn't parse \(Self.self) from \"\(rawValue)\"", error)
      return nil
    }
  }
}
