import Sh

extension Simctl {
  
  public struct DeviceType: Decodable {
    public let productFamily: String
    public let name: String
    public let identifier: Identifier
    public let modelIdentifier: String
    
    public let bundlePath: String
    
    public let maxRuntimeVersion: Int
    public let maxRuntimeVersionString: String
    
    public let minRuntimeVersionString: String
    public let minRuntimeVersion: Int
    
    public struct Identifier: RawRepresentable, Codable, Hashable, ExpressibleByStringLiteral {
      public typealias StringLiteralType = String
      public let rawValue: String
      public init?(rawValue: String) {
        self.rawValue = rawValue
      }
      public init(stringLiteral: String) {
        self.rawValue = stringLiteral
      }
      
      public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
      }
      
      public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
      }
    }
  }
  
  public static func listDeviceTypes() throws -> [DeviceType] {
    struct Wrapper: Decodable {
      let devicetypes: [DeviceType]
    }
    let wrapper = try sh(Wrapper.self, "xcrun simctl list -j devicetypes")
    return wrapper.devicetypes
  }
}
