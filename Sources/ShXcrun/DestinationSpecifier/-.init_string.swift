import Foundation

extension DestinationSpecifier {
  public init(string: String) throws {
    var _platform: Platform? = nil
    var _os: String? = nil
    var _name: String? = nil
    var _id: String? = nil
    var _variant: String? = nil
    var copy = string
    if let variantRange = string.range(of: "variant:Designed for [iPad,iPhone],") {
      copy.removeSubrange(variantRange)
      _variant = "Designed for [iPad,iPhone]"
    }

    let keyValuePairs = copy
      .dropFirst() // drop leading `{`
      .dropLast() // drop trailing `}`
      .split(separator: ",")
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines ) }

    for string in keyValuePairs {
      let pair = string.split(separator: ":")
      guard let key = pair.first, let value = pair.last, key != value else {
        throw Errors.couldntParseKeyAndValue(string)
      }

      switch key {
      case "platform":
        guard let platform = Platform(rawValue: String(value)) else {
          throw Errors.couldntParsePlatform(String(value))
        }
        _platform = platform
      case "name":
        _name = String(value)
      case "OS":
        _os = String(value)
      case "id":
        _id = String(value)
      case "variant":
        _variant = String(value)
      default:
        continue
      }
    }

    guard let _platform = _platform else {
      throw Errors.missingPlatform
    }

    self.init(platform: _platform, os: _os, name: _name, id: _id, variant: _variant)
  }

  public enum Errors: Error, LocalizedError, CustomStringConvertible {
    case couldntParseKeyAndValue(String)
    case couldntParsePlatform(String)
    case missingPlatform
    case missingOS
    case missingName

    public var description: String {
      switch self {
      case .couldntParseKeyAndValue(let string):
        return "Couldn't parse key and value from `\(string)`"
      case .couldntParsePlatform(let string):
        return "Couldn't parse platform from `\(string)`"
      case .missingPlatform:
        return "`Platform` was missing"
      case .missingOS:
        return "`OS` was missing"
      case .missingName:
        return "`Name` was missing"
      }
    }

    public var errorDescription: String? { description }
  }
}
