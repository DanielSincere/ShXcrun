import Sh

extension Xcodebuild {
  /// lists the targets and configurations in a project, or the schemes in a workspace
  public func list() throws -> ProjectDescription {
    try sh(ProjectDescription.self, serializedCommand(action: "-list -json"))
  }
}

public struct ProjectDescription: Decodable {

  public let project: Project

  public struct Project: Decodable {
    public let name: String
    public let configurations: [String]
    public let schemes: [String]
    public let targets: [String]
  }

  public var schemes: [String] { project.schemes }
  public var configurations: [String] { project.configurations }
  public var targets: [String] {  project.targets }
}

/*
 {
   "project" : {
     "configurations" : [
       "Debug",
       "Release"
     ],
     "name" : "App",
     "schemes" : [
       "App"
     ],
     "targets" : [
       "App",
       "AppTests",
       "AppUITests"
     ]
   }
 }
 */
