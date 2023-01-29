import Sh

extension Simctl {

  public static func listRuntimes() throws -> [Runtime] {
    let cmd = "xcrun simctl list -j runtimes"
    let runtimes = try sh(Runtimes.self, cmd)
    return runtimes.runtimes
  }
  
  public struct Runtime: Decodable {
    public let bundlePath: String
    public let buildversion: String
    public let platform: String
    public let runtimeRoot: String
    public let identifier: String
    public let version: String
    public let isInternal: Bool
    public let isAvailable: Bool
    public let name: String
  }
  
  struct Runtimes: Decodable {
    let runtimes: [Runtime]
  }
}
