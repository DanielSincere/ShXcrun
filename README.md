# ShXcrun

A wrapper around `xcodebuild`, `agvtool`, and other `xcrun` tools, built on top of [Sh](https://github.com/FullQueueDeveloper/Sh.git).


## Installation

```
dependendies: [
.package(url: "https://github.com/FullQueueDeveloper/ShXcrun.git", from: "0.1.0")
]
```

## Xcodebuild

Create an `Xcodebuild` object, with the parameters that you need, for example `Xcodebuild(scheme: "MySceme")` and then call a method on it.

```
try Xcodebuild(scheme: "MySceme").test(.terminal)
```

To send the output to a log file

```
try Xcodebuild(scheme: "MySceme").test(.file("logs/test.log"))
```


## ExportOptionsPlist

Create an `ExportOptionsPlist` and call `write` to save it to a path on disk. `exportArchive` needs this path.

Perhaps your script looks something like this.

```
let exportOptionsPath = "/tmp/exportOptions.plist"
let plist = ExportOptionsPlist(distributionBundleIdentifier: "com.example.App")
try plist.write(to: exportOptionsPath)

let xcodeBuild = Xcodebuild(scheme: "MyScheme")
try xcodeBuild.archive(.file("logs/archive.log"), path: "products")
try xcodeBuild.exportArchive(.file("log/exportArchive.log"), archivePath: "products", exportPath: "products", exportOptionsPlistPath: exportOptionsPath)
```
