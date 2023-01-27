import Sh
import Foundation

extension SimCtl {
  public struct Device: Codable {
    public let lastBootedAt: Date?
    public let availabilityError: String?
    public let dataPath: String
    public let dataPathSize: Int
    public let logPath: String
    public let logPathSize: Int?
    public let udid: UUID
    public let isAvailable: Bool

    public let deviceTypeIdentifier:DeviceType.Identifier
    public let state: State
    public let name: String
    
    public enum State: String, Codable {
      case shutdown = "Shutdown"
    }
  }


  
  // Process.waitUntilExit never returns
  public static func listDevices() throws -> [DeviceType.Identifier: [Device]] {
    let wrapper = try sh(Devices.self, "xcrun simctl list -j devices")
    return wrapper.devices
  }
  
  struct Devices: Codable {
    @DictionaryWrapper 
    var devices: [DeviceType.Identifier: [Device]]
  }
}

@propertyWrapper
public struct DictionaryWrapper<Key: Hashable & RawRepresentable, Value: Codable>: Codable where Key.RawValue: Codable & Hashable {
  public var wrappedValue: [Key: Value]
  
  public init() {
    wrappedValue = [:]
  }
  
  public init(wrappedValue: [Key: Value]) {
    self.wrappedValue = wrappedValue
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawKeyedDictionary = try container.decode([Key.RawValue: Value].self)
    
    wrappedValue = [:]
    for (rawKey, value) in rawKeyedDictionary {
      guard let key = Key(rawValue: rawKey) else {
        throw DecodingError.dataCorruptedError(
          in: container,
          debugDescription: "Invalid key: cannot initialize '\(Key.self)' from invalid '\(Key.RawValue.self)' value '\(rawKey)'")
      }
      wrappedValue[key] = value
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    let rawKeyedDictionary = Dictionary(uniqueKeysWithValues: wrappedValue.map { ($0.rawValue, $1) })
    var container = encoder.singleValueContainer()
    try container.encode(rawKeyedDictionary)
  }
}
