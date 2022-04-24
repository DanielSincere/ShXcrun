import Foundation

extension ExportOptionsPlist {
  public func write(to path: String) throws {
    let data = try PropertyListEncoder().encode(self)
    try data.write(to: URL(fileURLWithPath: path), options: .atomic)
  }
}
