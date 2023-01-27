import Sh

extension SimCtl {
  /**
   Boot up a simulator
   - Parameters:
    - sink: where to send output
    - arch: specify the architecture to use when booting the simulator (eg: `arm64` or `x86_64`)
   */
  func bootUp(_ sink: Sink = .terminal, simulator name: String, arch: String? = nil) throws {
    var cmd = "xcrun simctl bootstatus '\(name)' -b"
    if let arch {
      cmd += " --arch '\(arch)'"
    }
    try sh(sink, cmd)
  }
}
