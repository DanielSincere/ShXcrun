import Sh
import Foundation

extension Simctl {
  public static func listDevices() throws -> [DeviceType.Identifier: [Device]] {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    let devices = try sh(Devices.self,
                         decodedBy: decoder,
                         "xcrun simctl list -j devices")
    return devices.deviceTypeIdsToDevices
  }
  
  public struct Device: Codable {
    public let lastBootedAt: Date?
    public let availabilityError: String?
    public let dataPath: String
    public let dataPathSize: Int
    public let logPath: String
    public let logPathSize: Int?
    public let udid: UUID
    public let isAvailable: Bool

    public let deviceTypeIdentifier: DeviceType.Identifier
    public let state: State
    public let name: String
    
    public enum State: String, Codable {
      case shutdown = "Shutdown"
    }
  }
  
  struct Devices: Codable {
    let devices: [String: [Simctl.Device]]
    
    var deviceTypeIdsToDevices: [Simctl.DeviceType.Identifier: [Simctl.Device]] {
      devices.reduce(into: [:]) { result, next in
        result[Simctl.DeviceType.Identifier(stringLiteral: next.key)] = next.value
      }
    }
  }
}
