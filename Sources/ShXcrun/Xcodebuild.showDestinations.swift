import Sh
import Foundation

extension Xcodebuild {

  /// Show available build destinations
  public func showDestinations() throws -> [DestinationSpecifier]{
    try showDestinations(all: false).available
  }

  public func showAllDestinations() throws -> (available: [DestinationSpecifier], ineligible: [DestinationSpecifier]) {
    try showDestinations(all: true)
  }

  private func showDestinations(all: Bool) throws -> (available: [DestinationSpecifier], ineligible: [DestinationSpecifier]) {

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
      throw Sh.Errors.unexpectedNilDataError
    }

    let lines = allLines.drop { !$0.hasPrefix("Available destinations") && !$0.hasPrefix("Ineligible destinations")  }

    var availableDestinations: [DestinationSpecifier] = []
    var ineligibleDestinations: [DestinationSpecifier] = []

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

      DestinationSpecifier(rawValue: line).map {
        hasReachedIneligibleSection
        ? ineligibleDestinations.append($0)
        : availableDestinations.append($0)
      }
    }

    return (availableDestinations, ineligibleDestinations)
  }

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
