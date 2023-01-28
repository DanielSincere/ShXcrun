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

    public let deviceTypeIdentifier: DeviceType.Identifier
    public let state: State
    public let name: String
    
    public enum State: String, Codable {
      case shutdown = "Shutdown"
    }
  }
  
  // Process.waitUntilExit never returns
  public static func listDevices() throws -> [DeviceType.Identifier: [Device]] {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let wrapper = try sh(Devices.self, decodedBy: decoder, "xcrun simctl list -j devices")
    return wrapper.deviceTypeIdsToDevices
  }
  
  struct Devices: Codable {
    let devices: [String: [SimCtl.Device]]
    
    var deviceTypeIdsToDevices: [SimCtl.DeviceType.Identifier: [SimCtl.Device]] {
      devices.reduce(into: [:]) { result, next in
        result[SimCtl.DeviceType.Identifier(stringLiteral: next.key)] = next.value
      }
    }
  }
}
