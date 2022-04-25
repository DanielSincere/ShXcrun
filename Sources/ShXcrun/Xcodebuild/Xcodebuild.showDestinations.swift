import Sh
import Foundation

extension Xcodebuild {

  /// Show available build destinations
  public func showDestinations() throws -> [Destination] {
    try showDestinations(all: false).available
  }

  public func showAllDestinations() throws -> (available: [Destination], ineligible: [Destination]) {
    try showDestinations(all: true)
  }

  private func showDestinations(all: Bool) throws -> (available: [Destination], ineligible: [Destination]) {

    let output = try Process(cmd: serializedCommand(action: "-showdestinations"))
      .runReturningAllOutput()

    if let terminationError = output.terminationError {
      if let showDestinationsError = ShowDestinationsRequiresWorkspaceAndSchemeError(stdErr: output.stdErr) {
        throw showDestinationsError
      } else {
        throw terminationError
      }
    }

    guard let allLines = output.stdOut?.asTrimmedString()?.asTrimmedLines() else {
      throw UnexpectedMissingData()
    }

    let lines = allLines.drop { !$0.hasPrefix("Available destinations") && !$0.hasPrefix("Ineligible destinations")  }

    var availableDestinations: [Destination] = []
    var ineligibleDestinations: [Destination] = []

    var hasReachedIneligibleSection = false

    for line in lines {
      if line.hasPrefix("Available destinations") {
        continue
      }

      if line.hasPrefix("Ineligible destinations") {
        if all {
          hasReachedIneligibleSection = true
          continue
        } else {
          return (availableDestinations, [])
        }
      }

      Destination(rawValue: line).map {
        hasReachedIneligibleSection
        ? ineligibleDestinations.append($0)
        : availableDestinations.append($0)
      }
    }

    return (availableDestinations, ineligibleDestinations)
  }

  struct UnexpectedMissingData: Error {}
  
  struct ShowDestinationsRequiresWorkspaceAndSchemeError: Error, LocalizedError, CustomStringConvertible {
    init?(stdErr: Data?) {
      guard let trimmedString = stdErr?.asTrimmedString(), trimmedString.hasSuffix("-showdestinations requires a workspace and scheme.") else {
        return nil
      }
    }
    var description: String { errorDescription }
    var errorDescription: String { "-showdestinations requires a workspace and scheme"
    }
  }
}

extension String {
  func asTrimmedLines() -> [String] {
    self.split(separator: "\n").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
  }
}
