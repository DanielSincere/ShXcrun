import XCTest
@testable import ShXcrun

final class SimCtlTests: XCTestCase {
  
  func testListDeviceTypes() {
    XCTAssertNoThrow(try SimCtl.listDeviceTypes())
  }
  
  func testListDevices() {
    XCTAssertNoThrow(try SimCtl.listDevices())
  }
  
  func testDeviceParsing() throws {
    
    let sample = #"""
      {
        "lastBootedAt" : "2022-10-29T19:22:22Z",
        "dataPath" : "\/Users\/xxx\/Library\/Developer\/CoreSimulator\/Devices\/8BED9173-F12C-4E7E-ABC2-E78041A4CBF4\/data",
        "dataPathSize" : 1588023296,
        "logPath" : "\/Users\/xxx\/Library\/Logs\/CoreSimulator\/8BED9173-F12C-4E7E-ABC2-E78041A4CBF4",
        "udid" : "8BED9173-F12C-4E7E-ABC2-E78041A4CBF4",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 327680,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-X",
        "state" : "Shutdown",
        "name" : "iPhone X 15.5"
      }
    """#
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let device = try decoder.decode(SimCtl.Device.self, from: sample.data(using: .utf8)!)
    XCTAssertEqual(device.name, "iPhone X 15.5")
  }
  
  func testDevicesOutputDecoding() throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    struct Devices: Codable {
      //SimCtl.DeviceType.Identifier
      
      let devices: [String: [SimCtl.Device]]
      
      var deviceTypeIdsToDevices: [SimCtl.DeviceType.Identifier: [SimCtl.Device]] {
        devices.reduce(into: [:]) { result, next in
          result[SimCtl.DeviceType.Identifier(stringLiteral: next.key)] = next.value
        }
      }
    }
    let devices = try decoder.decode(Devices.self, from: devicesOutput.data(using: .utf8)!)
    XCTAssertEqual(devices.deviceTypeIdsToDevices.count, 9)
  }
  
  
}

private let devicesOutput: String = #"""
{
  "devices" : {
    "com.apple.CoreSimulator.SimRuntime.iOS-15-5" : [
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/48E795C4-E0C7-46B5-95E4-0ECF6AA48704\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/48E795C4-E0C7-46B5-95E4-0ECF6AA48704",
        "udid" : "48E795C4-E0C7-46B5-95E4-0ECF6AA48704",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-8",
        "state" : "Shutdown",
        "name" : "iPhone 8"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/8FAC1CE1-564E-48E7-9436-2EBB653A1DA3\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/8FAC1CE1-564E-48E7-9436-2EBB653A1DA3",
        "udid" : "8FAC1CE1-564E-48E7-9436-2EBB653A1DA3",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-8-Plus",
        "state" : "Shutdown",
        "name" : "iPhone 8 Plus"
      },
      {
        "lastBootedAt" : "2022-10-29T19:22:22Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/8BED9173-F12C-4E7E-ABC2-E78041A4CBF4\/data",
        "dataPathSize" : 1588023296,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/8BED9173-F12C-4E7E-ABC2-E78041A4CBF4",
        "udid" : "8BED9173-F12C-4E7E-ABC2-E78041A4CBF4",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 327680,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-X",
        "state" : "Shutdown",
        "name" : "iPhone X 15.5"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D735BF10-78B6-4EB8-93A8-BB93B6B7A303\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D735BF10-78B6-4EB8-93A8-BB93B6B7A303",
        "udid" : "D735BF10-78B6-4EB8-93A8-BB93B6B7A303",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11",
        "state" : "Shutdown",
        "name" : "iPhone 11"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D14010CC-49F1-434D-851E-3AABD6376469\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D14010CC-49F1-434D-851E-3AABD6376469",
        "udid" : "D14010CC-49F1-434D-851E-3AABD6376469",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 11 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/91FDEF58-1B9C-4C46-BF5C-727268C2D023\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/91FDEF58-1B9C-4C46-BF5C-727268C2D023",
        "udid" : "91FDEF58-1B9C-4C46-BF5C-727268C2D023",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 11 Pro Max"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/1B94009E-1398-4D93-AFD8-777FD27CE55F\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/1B94009E-1398-4D93-AFD8-777FD27CE55F",
        "udid" : "1B94009E-1398-4D93-AFD8-777FD27CE55F",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-mini",
        "state" : "Shutdown",
        "name" : "iPhone 12 mini"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/FF839B0F-C88B-49E3-9455-D8082DA66492\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/FF839B0F-C88B-49E3-9455-D8082DA66492",
        "udid" : "FF839B0F-C88B-49E3-9455-D8082DA66492",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12",
        "state" : "Shutdown",
        "name" : "iPhone 12"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D56C49C9-EAA9-4FE1-A386-7548CC03B34F\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D56C49C9-EAA9-4FE1-A386-7548CC03B34F",
        "udid" : "D56C49C9-EAA9-4FE1-A386-7548CC03B34F",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 12 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/4C68B8B5-9F27-4BBC-9ECD-8FC4BD83AF04\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/4C68B8B5-9F27-4BBC-9ECD-8FC4BD83AF04",
        "udid" : "4C68B8B5-9F27-4BBC-9ECD-8FC4BD83AF04",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 12 Pro Max"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/BB1B67BA-F631-4069-961A-9FD470F5F244\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/BB1B67BA-F631-4069-961A-9FD470F5F244",
        "udid" : "BB1B67BA-F631-4069-961A-9FD470F5F244",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 13 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/0C5081FB-08C2-48AB-A667-297CC22F26D4\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/0C5081FB-08C2-48AB-A667-297CC22F26D4",
        "udid" : "0C5081FB-08C2-48AB-A667-297CC22F26D4",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 13 Pro Max"
      },
      {
        "lastBootedAt" : "2022-09-05T05:01:26Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/43C9203A-C88A-4AE2-B65D-E9E6B5975496\/data",
        "dataPathSize" : 4493266944,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/43C9203A-C88A-4AE2-B65D-E9E6B5975496",
        "udid" : "43C9203A-C88A-4AE2-B65D-E9E6B5975496",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 483328,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-mini",
        "state" : "Shutdown",
        "name" : "iPhone 13 mini"
      },
      {
        "lastBootedAt" : "2022-08-14T16:34:24Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/18535F7D-0D4B-46FA-B3EF-8DA49EAE2087\/data",
        "dataPathSize" : 3267809280,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/18535F7D-0D4B-46FA-B3EF-8DA49EAE2087",
        "udid" : "18535F7D-0D4B-46FA-B3EF-8DA49EAE2087",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 425984,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13",
        "state" : "Shutdown",
        "name" : "iPhone 13"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/894C12E0-A452-45BB-ADBB-2E6C33FED9E8\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/894C12E0-A452-45BB-ADBB-2E6C33FED9E8",
        "udid" : "894C12E0-A452-45BB-ADBB-2E6C33FED9E8",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-SE-3rd-generation",
        "state" : "Shutdown",
        "name" : "iPhone SE (3rd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/2834097C-7A24-442B-B421-4E3C8D7E1214\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/2834097C-7A24-442B-B421-4E3C8D7E1214",
        "udid" : "2834097C-7A24-442B-B421-4E3C8D7E1214",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPod-touch--7th-generation-",
        "state" : "Shutdown",
        "name" : "iPod touch (7th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D5A0905E-6128-4788-9487-968CBDA6B601\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D5A0905E-6128-4788-9487-968CBDA6B601",
        "udid" : "D5A0905E-6128-4788-9487-968CBDA6B601",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro--9-7-inch-",
        "state" : "Shutdown",
        "name" : "iPad Pro (9.7-inch)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/FAA3895C-CFCE-4713-BEA9-145EF9FE5A9D\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/FAA3895C-CFCE-4713-BEA9-145EF9FE5A9D",
        "udid" : "FAA3895C-CFCE-4713-BEA9-145EF9FE5A9D",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-9th-generation",
        "state" : "Shutdown",
        "name" : "iPad (9th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/EF05FF82-FDDE-4818-9C10-0A5C3739258D\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/EF05FF82-FDDE-4818-9C10-0A5C3739258D",
        "udid" : "EF05FF82-FDDE-4818-9C10-0A5C3739258D",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-11-inch-3rd-generation",
        "state" : "Shutdown",
        "name" : "iPad Pro (11-inch) (3rd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/21C50F13-3B12-47C7-8FA7-367F83F42CC2\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/21C50F13-3B12-47C7-8FA7-367F83F42CC2",
        "udid" : "21C50F13-3B12-47C7-8FA7-367F83F42CC2",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-12-9-inch-5th-generation",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (5th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/3A456B69-A461-4508-A057-F712DC27B641\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/3A456B69-A461-4508-A057-F712DC27B641",
        "udid" : "3A456B69-A461-4508-A057-F712DC27B641",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Air-5th-generation",
        "state" : "Shutdown",
        "name" : "iPad Air (5th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/BC043763-C414-4858-9F8F-AF177DBF04CC\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/BC043763-C414-4858-9F8F-AF177DBF04CC",
        "udid" : "BC043763-C414-4858-9F8F-AF177DBF04CC",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-mini-6th-generation",
        "state" : "Shutdown",
        "name" : "iPad mini (6th generation)"
      }
    ],
    "com.apple.CoreSimulator.SimRuntime.watchOS-8-5" : [
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D4FFD13C-D9C1-4DA2-B072-518BACB014F7\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D4FFD13C-D9C1-4DA2-B072-518BACB014F7",
        "udid" : "D4FFD13C-D9C1-4DA2-B072-518BACB014F7",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-5-40mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 5 - 40mm"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/082F1EE4-7E4D-4569-A55F-6D96692BA699\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/082F1EE4-7E4D-4569-A55F-6D96692BA699",
        "udid" : "082F1EE4-7E4D-4569-A55F-6D96692BA699",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-5-44mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 5 - 44mm"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/73ACBBD8-FDCD-43AF-BCDD-EB45D3878939\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/73ACBBD8-FDCD-43AF-BCDD-EB45D3878939",
        "udid" : "73ACBBD8-FDCD-43AF-BCDD-EB45D3878939",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-6-40mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 6 - 40mm"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/03793F4D-A59E-448A-B32D-73F15A95A016\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/03793F4D-A59E-448A-B32D-73F15A95A016",
        "udid" : "03793F4D-A59E-448A-B32D-73F15A95A016",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-6-44mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 6 - 44mm"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/FAE5804D-8D04-4CF4-B283-D6D6032EE467\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/FAE5804D-8D04-4CF4-B283-D6D6032EE467",
        "udid" : "FAE5804D-8D04-4CF4-B283-D6D6032EE467",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-7-41mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 7 - 41mm"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/5164C1EF-9003-4E91-B50F-C291DA28E8C9\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/5164C1EF-9003-4E91-B50F-C291DA28E8C9",
        "udid" : "5164C1EF-9003-4E91-B50F-C291DA28E8C9",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-7-45mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 7 - 45mm"
      }
    ],
    "com.apple.CoreSimulator.SimRuntime.iOS-15-4" : [
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/9BFF6750-F93E-4433-9FA2-83DE31D65675\/data",
        "dataPathSize" : 1726984192,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/9BFF6750-F93E-4433-9FA2-83DE31D65675",
        "udid" : "9BFF6750-F93E-4433-9FA2-83DE31D65675",
        "isAvailable" : false,
        "logPathSize" : 430080,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-8",
        "state" : "Shutdown",
        "name" : "iPhone 8"
      },
      {
        "lastBootedAt" : "2022-06-27T23:48:23Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/06607422-D8E7-4936-843E-89BFC8E57E2E\/data",
        "dataPathSize" : 1534140416,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/06607422-D8E7-4936-843E-89BFC8E57E2E",
        "udid" : "06607422-D8E7-4936-843E-89BFC8E57E2E",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 430080,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-8-Plus",
        "state" : "Shutdown",
        "name" : "iPhone 8 Plus"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/899CB7A2-39D8-4BF4-B7AC-7421CE11D378\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/899CB7A2-39D8-4BF4-B7AC-7421CE11D378",
        "udid" : "899CB7A2-39D8-4BF4-B7AC-7421CE11D378",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11",
        "state" : "Shutdown",
        "name" : "iPhone 11"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/A4ED4639-2656-4645-8ECA-AAA491D6E6B5\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/A4ED4639-2656-4645-8ECA-AAA491D6E6B5",
        "udid" : "A4ED4639-2656-4645-8ECA-AAA491D6E6B5",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 11 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/700B6570-3FBE-4802-B063-700E58C757B3\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/700B6570-3FBE-4802-B063-700E58C757B3",
        "udid" : "700B6570-3FBE-4802-B063-700E58C757B3",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 11 Pro Max"
      },
      {
        "lastBootedAt" : "2022-06-18T07:44:29Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/8FB688B1-AFEC-496D-80A6-A1A8D74039D8\/data",
        "dataPathSize" : 4013260800,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/8FB688B1-AFEC-496D-80A6-A1A8D74039D8",
        "udid" : "8FB688B1-AFEC-496D-80A6-A1A8D74039D8",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 602112,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-mini",
        "state" : "Shutdown",
        "name" : "iPhone 12 mini"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/9A981277-D3E4-4C57-AD75-E78446FF89E5\/data",
        "dataPathSize" : 3606528000,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/9A981277-D3E4-4C57-AD75-E78446FF89E5",
        "udid" : "9A981277-D3E4-4C57-AD75-E78446FF89E5",
        "isAvailable" : false,
        "logPathSize" : 430080,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12",
        "state" : "Shutdown",
        "name" : "iPhone 12"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D40F4074-5792-4261-8B10-350C5D43AD98\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D40F4074-5792-4261-8B10-350C5D43AD98",
        "udid" : "D40F4074-5792-4261-8B10-350C5D43AD98",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 12 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/846347AB-F8B3-42AF-A0FD-3CE1D4F371A7\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/846347AB-F8B3-42AF-A0FD-3CE1D4F371A7",
        "udid" : "846347AB-F8B3-42AF-A0FD-3CE1D4F371A7",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 12 Pro Max"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/315CA696-108D-4620-B2C5-80B4DDA6F0BE\/data",
        "dataPathSize" : 1655050240,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/315CA696-108D-4620-B2C5-80B4DDA6F0BE",
        "udid" : "315CA696-108D-4620-B2C5-80B4DDA6F0BE",
        "isAvailable" : false,
        "logPathSize" : 352256,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 13 Pro"
      },
      {
        "lastBootedAt" : "2022-06-27T23:47:20Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/DE0952EB-E226-4195-B9BD-0706B74303BB\/data",
        "dataPathSize" : 3676168192,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/DE0952EB-E226-4195-B9BD-0706B74303BB",
        "udid" : "DE0952EB-E226-4195-B9BD-0706B74303BB",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 512000,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 13 Pro Max"
      },
      {
        "lastBootedAt" : "2022-07-01T05:50:49Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/6DF876C9-A97B-4E57-9365-F7097550CAF2\/data",
        "dataPathSize" : 9819037696,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/6DF876C9-A97B-4E57-9365-F7097550CAF2",
        "udid" : "6DF876C9-A97B-4E57-9365-F7097550CAF2",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 704512,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-mini",
        "state" : "Shutdown",
        "name" : "iPhone 13 mini"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/EA0D4596-D7DD-4E41-998C-DF3530340C9E\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/EA0D4596-D7DD-4E41-998C-DF3530340C9E",
        "udid" : "EA0D4596-D7DD-4E41-998C-DF3530340C9E",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-mini",
        "state" : "Shutdown",
        "name" : "iPhone 13 mini"
      },
      {
        "lastBootedAt" : "2022-07-13T15:14:51Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/E4290123-6031-4DEE-B34B-064F7D237E29\/data",
        "dataPathSize" : 6695895040,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/E4290123-6031-4DEE-B34B-064F7D237E29",
        "udid" : "E4290123-6031-4DEE-B34B-064F7D237E29",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 892928,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13",
        "state" : "Shutdown",
        "name" : "iPhone 13"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/71500F6B-03E1-4D37-8539-8C66C01D32E7\/data",
        "dataPathSize" : 1792581632,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/71500F6B-03E1-4D37-8539-8C66C01D32E7",
        "udid" : "71500F6B-03E1-4D37-8539-8C66C01D32E7",
        "isAvailable" : false,
        "logPathSize" : 618496,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-SE-3rd-generation",
        "state" : "Shutdown",
        "name" : "iPhone SE (3rd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/C49A93C5-1BB0-4A09-98C7-8999CA578D7B\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/C49A93C5-1BB0-4A09-98C7-8999CA578D7B",
        "udid" : "C49A93C5-1BB0-4A09-98C7-8999CA578D7B",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPod-touch--7th-generation-",
        "state" : "Shutdown",
        "name" : "iPod touch (7th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/7423BFEF-F275-43DB-94DE-491D7F92F5E0\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/7423BFEF-F275-43DB-94DE-491D7F92F5E0",
        "udid" : "7423BFEF-F275-43DB-94DE-491D7F92F5E0",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro--9-7-inch-",
        "state" : "Shutdown",
        "name" : "iPad Pro (9.7-inch)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D43CF301-C3CE-496E-811B-49EA6802756A\/data",
        "dataPathSize" : 856858624,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D43CF301-C3CE-496E-811B-49EA6802756A",
        "udid" : "D43CF301-C3CE-496E-811B-49EA6802756A",
        "isAvailable" : false,
        "logPathSize" : 348160,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---2nd-generation-",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (2nd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/0FEC71AB-B076-4560-9168-9B6A785E670A\/data",
        "dataPathSize" : 854712320,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/0FEC71AB-B076-4560-9168-9B6A785E670A",
        "udid" : "0FEC71AB-B076-4560-9168-9B6A785E670A",
        "isAvailable" : false,
        "logPathSize" : 348160,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---3rd-generation-",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (3rd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/20CCA78D-E4B2-47CB-944B-84DBBF3736EF\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/20CCA78D-E4B2-47CB-944B-84DBBF3736EF",
        "udid" : "20CCA78D-E4B2-47CB-944B-84DBBF3736EF",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-9th-generation",
        "state" : "Shutdown",
        "name" : "iPad (9th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/6EEAFD65-8F4D-470D-894D-A1B8E2C53838\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/6EEAFD65-8F4D-470D-894D-A1B8E2C53838",
        "udid" : "6EEAFD65-8F4D-470D-894D-A1B8E2C53838",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-11-inch-3rd-generation",
        "state" : "Shutdown",
        "name" : "iPad Pro (11-inch) (3rd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/2918ECE8-DC56-4AF7-A6E2-9D0DE7AED36B\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/2918ECE8-DC56-4AF7-A6E2-9D0DE7AED36B",
        "udid" : "2918ECE8-DC56-4AF7-A6E2-9D0DE7AED36B",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-12-9-inch-5th-generation",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (5th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/B4120554-33D8-454C-A5EA-8C80F170DF66\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/B4120554-33D8-454C-A5EA-8C80F170DF66",
        "udid" : "B4120554-33D8-454C-A5EA-8C80F170DF66",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Air-5th-generation",
        "state" : "Shutdown",
        "name" : "iPad Air (5th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D0D69B0A-58A6-46F6-AE72-5B2F8085F9FB\/data",
        "dataPathSize" : 1402118144,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D0D69B0A-58A6-46F6-AE72-5B2F8085F9FB",
        "udid" : "D0D69B0A-58A6-46F6-AE72-5B2F8085F9FB",
        "isAvailable" : false,
        "logPathSize" : 352256,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-mini-6th-generation",
        "state" : "Shutdown",
        "name" : "iPad mini (6th generation)"
      }
    ],
    "com.apple.CoreSimulator.SimRuntime.iOS-16-0" : [
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/BED5D56E-7770-42F0-B747-975D30FC45E7\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/BED5D56E-7770-42F0-B747-975D30FC45E7",
        "udid" : "BED5D56E-7770-42F0-B747-975D30FC45E7",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-8",
        "state" : "Shutdown",
        "name" : "iPhone 8"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/807A20C9-537E-4682-80CC-90B69A5F6EAE\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/807A20C9-537E-4682-80CC-90B69A5F6EAE",
        "udid" : "807A20C9-537E-4682-80CC-90B69A5F6EAE",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-8-Plus",
        "state" : "Shutdown",
        "name" : "iPhone 8 Plus"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/2EDE9C22-CBD3-4B35-8B51-6483B60692DB\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/2EDE9C22-CBD3-4B35-8B51-6483B60692DB",
        "udid" : "2EDE9C22-CBD3-4B35-8B51-6483B60692DB",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11",
        "state" : "Shutdown",
        "name" : "iPhone 11"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/B03D4586-4896-4E09-B81F-2CD367BCC1B4\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/B03D4586-4896-4E09-B81F-2CD367BCC1B4",
        "udid" : "B03D4586-4896-4E09-B81F-2CD367BCC1B4",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 11 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/DE36BE5A-0E63-493C-8290-BE4529C1D65B\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/DE36BE5A-0E63-493C-8290-BE4529C1D65B",
        "udid" : "DE36BE5A-0E63-493C-8290-BE4529C1D65B",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 11 Pro Max"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/34A34DC0-7159-4849-B27E-08C04B56456F\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/34A34DC0-7159-4849-B27E-08C04B56456F",
        "udid" : "34A34DC0-7159-4849-B27E-08C04B56456F",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-mini",
        "state" : "Shutdown",
        "name" : "iPhone 12 mini"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/61BE534A-5DF7-4132-AC75-FC4E4FB0CE15\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/61BE534A-5DF7-4132-AC75-FC4E4FB0CE15",
        "udid" : "61BE534A-5DF7-4132-AC75-FC4E4FB0CE15",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12",
        "state" : "Shutdown",
        "name" : "iPhone 12"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/975592DD-BD8E-420F-9CAD-853D9F6642B0\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/975592DD-BD8E-420F-9CAD-853D9F6642B0",
        "udid" : "975592DD-BD8E-420F-9CAD-853D9F6642B0",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 12 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/7AC4DC54-B27A-4533-8B80-73973BFC6AF8\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/7AC4DC54-B27A-4533-8B80-73973BFC6AF8",
        "udid" : "7AC4DC54-B27A-4533-8B80-73973BFC6AF8",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 12 Pro Max"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/042C3B78-F4F6-4A16-933A-F5FD111EFD1F\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/042C3B78-F4F6-4A16-933A-F5FD111EFD1F",
        "udid" : "042C3B78-F4F6-4A16-933A-F5FD111EFD1F",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 13 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/1A4BF476-11E6-4631-AA0D-B7B2686EC7B5\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/1A4BF476-11E6-4631-AA0D-B7B2686EC7B5",
        "udid" : "1A4BF476-11E6-4631-AA0D-B7B2686EC7B5",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 13 Pro Max"
      },
      {
        "lastBootedAt" : "2022-07-10T23:51:02Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/57F9CF85-C5C3-4391-9370-FAB673ACD122\/data",
        "dataPathSize" : 372658176,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/57F9CF85-C5C3-4391-9370-FAB673ACD122",
        "udid" : "57F9CF85-C5C3-4391-9370-FAB673ACD122",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 32768,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-mini",
        "state" : "Shutdown",
        "name" : "iPhone 13 mini"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/4E139169-F085-4F38-8B0F-009ED9D374F8\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/4E139169-F085-4F38-8B0F-009ED9D374F8",
        "udid" : "4E139169-F085-4F38-8B0F-009ED9D374F8",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13",
        "state" : "Shutdown",
        "name" : "iPhone 13"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/C6A749D4-B75F-4F28-8545-339D61142137\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/C6A749D4-B75F-4F28-8545-339D61142137",
        "udid" : "C6A749D4-B75F-4F28-8545-339D61142137",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-SE-3rd-generation",
        "state" : "Shutdown",
        "name" : "iPhone SE (3rd generation)"
      },
      {
        "lastBootedAt" : "2022-09-26T15:39:16Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/51CBD07E-EA42-4717-8DDD-FDFCD3290A63\/data",
        "dataPathSize" : 626278400,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/51CBD07E-EA42-4717-8DDD-FDFCD3290A63",
        "udid" : "51CBD07E-EA42-4717-8DDD-FDFCD3290A63",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 65536,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14",
        "state" : "Shutdown",
        "name" : "iPhone 14"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/E974E1EC-34E5-4E7B-8532-66B9E04BCAB1\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/E974E1EC-34E5-4E7B-8532-66B9E04BCAB1",
        "udid" : "E974E1EC-34E5-4E7B-8532-66B9E04BCAB1",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14-Plus",
        "state" : "Shutdown",
        "name" : "iPhone 14 Plus"
      },
      {
        "lastBootedAt" : "2022-11-09T04:30:22Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D4C80C7C-07DE-4BA7-816B-D0C52EF575F9\/data",
        "dataPathSize" : 5814521856,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D4C80C7C-07DE-4BA7-816B-D0C52EF575F9",
        "udid" : "D4C80C7C-07DE-4BA7-816B-D0C52EF575F9",
        "isAvailable" : false,
        "availabilityError" : "runtime profile not found",
        "logPathSize" : 442368,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 14 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/DBBFF255-E5BE-4F45-A068-42A84CD001F2\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/DBBFF255-E5BE-4F45-A068-42A84CD001F2",
        "udid" : "DBBFF255-E5BE-4F45-A068-42A84CD001F2",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 14 Pro Max"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/7A110B33-096D-43A9-9C6B-2747E7168776\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/7A110B33-096D-43A9-9C6B-2747E7168776",
        "udid" : "7A110B33-096D-43A9-9C6B-2747E7168776",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPod-touch--7th-generation-",
        "state" : "Shutdown",
        "name" : "iPod touch (7th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/9B6503E8-BCFA-4494-AACF-5493ED27D6C7\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/9B6503E8-BCFA-4494-AACF-5493ED27D6C7",
        "udid" : "9B6503E8-BCFA-4494-AACF-5493ED27D6C7",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro--9-7-inch-",
        "state" : "Shutdown",
        "name" : "iPad Pro (9.7-inch)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/DBBAAA94-8CDD-4123-BF78-E6418F9706FB\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/DBBAAA94-8CDD-4123-BF78-E6418F9706FB",
        "udid" : "DBBAAA94-8CDD-4123-BF78-E6418F9706FB",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-9th-generation",
        "state" : "Shutdown",
        "name" : "iPad (9th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/C2CE6D1B-9918-48E4-9A80-6E758AD66F11\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/C2CE6D1B-9918-48E4-9A80-6E758AD66F11",
        "udid" : "C2CE6D1B-9918-48E4-9A80-6E758AD66F11",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-11-inch-3rd-generation",
        "state" : "Shutdown",
        "name" : "iPad Pro (11-inch) (3rd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/59ACE879-D662-4353-9159-AC47929B6D02\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/59ACE879-D662-4353-9159-AC47929B6D02",
        "udid" : "59ACE879-D662-4353-9159-AC47929B6D02",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-12-9-inch-5th-generation",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (5th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/C6D4C88D-D288-4878-921C-4AA6BA93E1F5\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/C6D4C88D-D288-4878-921C-4AA6BA93E1F5",
        "udid" : "C6D4C88D-D288-4878-921C-4AA6BA93E1F5",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Air-5th-generation",
        "state" : "Shutdown",
        "name" : "iPad Air (5th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/F00A7283-2F5C-45DB-ADD3-28FB45E54519\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/F00A7283-2F5C-45DB-ADD3-28FB45E54519",
        "udid" : "F00A7283-2F5C-45DB-ADD3-28FB45E54519",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-mini-6th-generation",
        "state" : "Shutdown",
        "name" : "iPad mini (6th generation)"
      }
    ],
    "com.apple.CoreSimulator.SimRuntime.watchOS-8-3" : [
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/E9BE55A6-3A61-4ECB-A5A8-7E525E73090C\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/E9BE55A6-3A61-4ECB-A5A8-7E525E73090C",
        "udid" : "E9BE55A6-3A61-4ECB-A5A8-7E525E73090C",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-6-40mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 6 - 40mm"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/B6C1FB34-CEFF-44B1-8505-C6129FA4AC16\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/B6C1FB34-CEFF-44B1-8505-C6129FA4AC16",
        "udid" : "B6C1FB34-CEFF-44B1-8505-C6129FA4AC16",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-6-44mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 6 - 44mm"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/F156B5E6-A71F-42BB-8FC5-E71AFA5395B1\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/F156B5E6-A71F-42BB-8FC5-E71AFA5395B1",
        "udid" : "F156B5E6-A71F-42BB-8FC5-E71AFA5395B1",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-7-41mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 7 - 41mm"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/55B95A40-86A3-4D15-95D3-E4C8AC6AB900\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/55B95A40-86A3-4D15-95D3-E4C8AC6AB900",
        "udid" : "55B95A40-86A3-4D15-95D3-E4C8AC6AB900",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-7-45mm",
        "state" : "Shutdown",
        "name" : "Apple Watch Series 7 - 45mm"
      }
    ],
    "com.apple.CoreSimulator.SimRuntime.tvOS-15-2" : [
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/232D984E-854D-4073-B0E0-AD3E08238E61\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/232D984E-854D-4073-B0E0-AD3E08238E61",
        "udid" : "232D984E-854D-4073-B0E0-AD3E08238E61",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-TV-1080p",
        "state" : "Shutdown",
        "name" : "Apple TV"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/311D02A9-18E3-44CF-81AA-C62CBF53F947\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/311D02A9-18E3-44CF-81AA-C62CBF53F947",
        "udid" : "311D02A9-18E3-44CF-81AA-C62CBF53F947",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-TV-4K-2nd-generation-4K",
        "state" : "Shutdown",
        "name" : "Apple TV 4K (2nd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/A9191610-373E-4B21-B3E4-81A1BA9308FF\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/A9191610-373E-4B21-B3E4-81A1BA9308FF",
        "udid" : "A9191610-373E-4B21-B3E4-81A1BA9308FF",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-TV-4K-2nd-generation-1080p",
        "state" : "Shutdown",
        "name" : "Apple TV 4K (at 1080p) (2nd generation)"
      }
    ],
    "com.apple.CoreSimulator.SimRuntime.tvOS-15-4" : [
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/56A5B3D9-B906-40A4-9EC0-5D0780EE1C10\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/56A5B3D9-B906-40A4-9EC0-5D0780EE1C10",
        "udid" : "56A5B3D9-B906-40A4-9EC0-5D0780EE1C10",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-TV-1080p",
        "state" : "Shutdown",
        "name" : "Apple TV"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/258379AA-B1C6-4F2B-BCA2-7CD1DD32C68C\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/258379AA-B1C6-4F2B-BCA2-7CD1DD32C68C",
        "udid" : "258379AA-B1C6-4F2B-BCA2-7CD1DD32C68C",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-TV-4K-2nd-generation-4K",
        "state" : "Shutdown",
        "name" : "Apple TV 4K (2nd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/B8D3A5BD-32D3-4947-A913-20C4FAE02A42\/data",
        "dataPathSize" : 0,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/B8D3A5BD-32D3-4947-A913-20C4FAE02A42",
        "udid" : "B8D3A5BD-32D3-4947-A913-20C4FAE02A42",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.Apple-TV-4K-2nd-generation-1080p",
        "state" : "Shutdown",
        "name" : "Apple TV 4K (at 1080p) (2nd generation)"
      }
    ],
    "com.apple.CoreSimulator.SimRuntime.iOS-16-1" : [
      {
        "lastBootedAt" : "2022-12-14T19:31:58Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D61C89B3-935F-4E1C-8C92-5A6F11564ADA\/data",
        "dataPathSize" : 1026584576,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D61C89B3-935F-4E1C-8C92-5A6F11564ADA",
        "udid" : "D61C89B3-935F-4E1C-8C92-5A6F11564ADA",
        "isAvailable" : true,
        "logPathSize" : 135168,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-SE-3rd-generation",
        "state" : "Shutdown",
        "name" : "iPhone SE (3rd generation)"
      },
      {
        "lastBootedAt" : "2023-01-18T02:19:06Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/572E452C-8543-41DB-9CB8-4E07BA78FC6F\/data",
        "dataPathSize" : 3338629120,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/572E452C-8543-41DB-9CB8-4E07BA78FC6F",
        "udid" : "572E452C-8543-41DB-9CB8-4E07BA78FC6F",
        "isAvailable" : true,
        "logPathSize" : 421888,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14",
        "state" : "Shutdown",
        "name" : "iPhone 14"
      },
      {
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/096E19E3-FA07-49CF-AD44-1314BAA67103\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/096E19E3-FA07-49CF-AD44-1314BAA67103",
        "udid" : "096E19E3-FA07-49CF-AD44-1314BAA67103",
        "isAvailable" : true,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14-Plus",
        "state" : "Shutdown",
        "name" : "iPhone 14 Plus"
      },
      {
        "lastBootedAt" : "2023-01-23T01:23:05Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/87D2A1D3-98D6-450F-94DE-4B776AD9FDE1\/data",
        "dataPathSize" : 3315347456,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/87D2A1D3-98D6-450F-94DE-4B776AD9FDE1",
        "udid" : "87D2A1D3-98D6-450F-94DE-4B776AD9FDE1",
        "isAvailable" : true,
        "logPathSize" : 151552,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 14 Pro"
      },
      {
        "lastBootedAt" : "2023-01-23T02:17:39Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/F7D7D075-B04B-4FD2-9D71-2C802F1D02F1\/data",
        "dataPathSize" : 390483968,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/F7D7D075-B04B-4FD2-9D71-2C802F1D02F1",
        "udid" : "F7D7D075-B04B-4FD2-9D71-2C802F1D02F1",
        "isAvailable" : true,
        "logPathSize" : 57344,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 14 Pro Max"
      },
      {
        "lastBootedAt" : "2023-01-11T18:16:56Z",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/0CF845C8-B969-4D50-85AF-EE4F86EBD323\/data",
        "dataPathSize" : 1053532160,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/0CF845C8-B969-4D50-85AF-EE4F86EBD323",
        "udid" : "0CF845C8-B969-4D50-85AF-EE4F86EBD323",
        "isAvailable" : true,
        "logPathSize" : 77824,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Air-5th-generation",
        "state" : "Shutdown",
        "name" : "iPad Air (5th generation)"
      },
      {
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/A102BFF2-0818-4336-9659-F6A0D2D9582C\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/A102BFF2-0818-4336-9659-F6A0D2D9582C",
        "udid" : "A102BFF2-0818-4336-9659-F6A0D2D9582C",
        "isAvailable" : true,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-10th-generation",
        "state" : "Shutdown",
        "name" : "iPad (10th generation)"
      },
      {
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/25D42B1D-276C-4CE8-AF59-711B5C4FC849\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/25D42B1D-276C-4CE8-AF59-711B5C4FC849",
        "udid" : "25D42B1D-276C-4CE8-AF59-711B5C4FC849",
        "isAvailable" : true,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-mini-6th-generation",
        "state" : "Shutdown",
        "name" : "iPad mini (6th generation)"
      },
      {
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/60A4F3F9-E4FF-4510-9FB2-9D6E091A9783\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/60A4F3F9-E4FF-4510-9FB2-9D6E091A9783",
        "udid" : "60A4F3F9-E4FF-4510-9FB2-9D6E091A9783",
        "isAvailable" : true,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-11-inch-4th-generation-8GB",
        "state" : "Shutdown",
        "name" : "iPad Pro (11-inch) (4th generation)"
      },
      {
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/DDCE4DC2-4EF5-4799-9E16-E59C256DB8C4\/data",
        "dataPathSize" : 13316096,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/DDCE4DC2-4EF5-4799-9E16-E59C256DB8C4",
        "udid" : "DDCE4DC2-4EF5-4799-9E16-E59C256DB8C4",
        "isAvailable" : true,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-12-9-inch-6th-generation-8GB",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (6th generation)"
      }
    ],
    "com.apple.CoreSimulator.SimRuntime.iOS-15-2" : [
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/D38EFEF0-29D9-4608-9B97-8A72E7E9CF5A\/data",
        "dataPathSize" : 1004122112,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/D38EFEF0-29D9-4608-9B97-8A72E7E9CF5A",
        "udid" : "D38EFEF0-29D9-4608-9B97-8A72E7E9CF5A",
        "isAvailable" : false,
        "logPathSize" : 696320,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-8",
        "state" : "Shutdown",
        "name" : "iPhone 8"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/94A1DB25-D550-47B6-8A36-2D8304BAB3E8\/data",
        "dataPathSize" : 525221888,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/94A1DB25-D550-47B6-8A36-2D8304BAB3E8",
        "udid" : "94A1DB25-D550-47B6-8A36-2D8304BAB3E8",
        "isAvailable" : false,
        "logPathSize" : 335872,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-8-Plus",
        "state" : "Shutdown",
        "name" : "iPhone 8 Plus"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/CE842003-289C-4D2D-B5C9-D1FDB1346FFA\/data",
        "dataPathSize" : 1968242688,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/CE842003-289C-4D2D-B5C9-D1FDB1346FFA",
        "udid" : "CE842003-289C-4D2D-B5C9-D1FDB1346FFA",
        "isAvailable" : false,
        "logPathSize" : 487424,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-SE--2nd-generation-",
        "state" : "Shutdown",
        "name" : "iPhone SE (2nd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/81F6BD2C-51DE-4566-9C81-A1F008CABF3B\/data",
        "dataPathSize" : 1532272640,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/81F6BD2C-51DE-4566-9C81-A1F008CABF3B",
        "udid" : "81F6BD2C-51DE-4566-9C81-A1F008CABF3B",
        "isAvailable" : false,
        "logPathSize" : 499712,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 12 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/E427F83D-1015-40C3-A204-3B457197EBFC\/data",
        "dataPathSize" : 3110580224,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/E427F83D-1015-40C3-A204-3B457197EBFC",
        "udid" : "E427F83D-1015-40C3-A204-3B457197EBFC",
        "isAvailable" : false,
        "logPathSize" : 569344,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-Pro",
        "state" : "Shutdown",
        "name" : "iPhone 13 Pro"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/A7C5750C-6E87-487C-B25A-CD6C37B5DF03\/data",
        "dataPathSize" : 1907601408,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/A7C5750C-6E87-487C-B25A-CD6C37B5DF03",
        "udid" : "A7C5750C-6E87-487C-B25A-CD6C37B5DF03",
        "isAvailable" : false,
        "logPathSize" : 475136,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-Pro-Max",
        "state" : "Shutdown",
        "name" : "iPhone 13 Pro Max"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/6AC1333E-6B2A-4640-9F6F-E44C95176496\/data",
        "dataPathSize" : 8687493120,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/6AC1333E-6B2A-4640-9F6F-E44C95176496",
        "udid" : "6AC1333E-6B2A-4640-9F6F-E44C95176496",
        "isAvailable" : false,
        "logPathSize" : 1077248,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13-mini",
        "state" : "Shutdown",
        "name" : "iPhone 13 mini"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/BAD6E5E5-32F9-4853-862A-75A8EC24160A\/data",
        "dataPathSize" : 5930479616,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/BAD6E5E5-32F9-4853-862A-75A8EC24160A",
        "udid" : "BAD6E5E5-32F9-4853-862A-75A8EC24160A",
        "isAvailable" : false,
        "logPathSize" : 917504,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-13",
        "state" : "Shutdown",
        "name" : "iPhone 13"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/97561BCB-718D-43D3-A26B-D83EF44F8B65\/data",
        "dataPathSize" : 1128652800,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/97561BCB-718D-43D3-A26B-D83EF44F8B65",
        "udid" : "97561BCB-718D-43D3-A26B-D83EF44F8B65",
        "isAvailable" : false,
        "logPathSize" : 434176,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro--9-7-inch-",
        "state" : "Shutdown",
        "name" : "iPad Pro (9.7-inch)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/93652B8A-F32A-47E6-BF15-1F9D744BB7BE\/data",
        "dataPathSize" : 781615104,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/93652B8A-F32A-47E6-BF15-1F9D744BB7BE",
        "udid" : "93652B8A-F32A-47E6-BF15-1F9D744BB7BE",
        "isAvailable" : false,
        "logPathSize" : 360448,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---2nd-generation-",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (2nd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/157AA732-5EC3-46AC-B393-609B8C467DCA\/data",
        "dataPathSize" : 641560576,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/157AA732-5EC3-46AC-B393-609B8C467DCA",
        "udid" : "157AA732-5EC3-46AC-B393-609B8C467DCA",
        "isAvailable" : false,
        "logPathSize" : 331776,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---3rd-generation-",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (3rd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/56A57E26-180B-4017-85F1-71968FDCB4C2\/data",
        "dataPathSize" : 1608204288,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/56A57E26-180B-4017-85F1-71968FDCB4C2",
        "udid" : "56A57E26-180B-4017-85F1-71968FDCB4C2",
        "isAvailable" : false,
        "logPathSize" : 430080,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-9th-generation",
        "state" : "Shutdown",
        "name" : "iPad (9th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/24EBB801-D88B-442F-BC16-DF6770DEED2D\/data",
        "dataPathSize" : 13312000,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/24EBB801-D88B-442F-BC16-DF6770DEED2D",
        "udid" : "24EBB801-D88B-442F-BC16-DF6770DEED2D",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Air--4th-generation-",
        "state" : "Shutdown",
        "name" : "iPad Air (4th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/8F055F32-96D2-413B-AC2C-350D0EBCEA45\/data",
        "dataPathSize" : 13312000,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/8F055F32-96D2-413B-AC2C-350D0EBCEA45",
        "udid" : "8F055F32-96D2-413B-AC2C-350D0EBCEA45",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-11-inch-3rd-generation",
        "state" : "Shutdown",
        "name" : "iPad Pro (11-inch) (3rd generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/4D5BD458-38BE-496B-B029-CDF05F55CA3B\/data",
        "dataPathSize" : 639447040,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/4D5BD458-38BE-496B-B029-CDF05F55CA3B",
        "udid" : "4D5BD458-38BE-496B-B029-CDF05F55CA3B",
        "isAvailable" : false,
        "logPathSize" : 331776,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-Pro-12-9-inch-5th-generation",
        "state" : "Shutdown",
        "name" : "iPad Pro (12.9-inch) (5th generation)"
      },
      {
        "availabilityError" : "runtime profile not found",
        "dataPath" : "\/Users\/username\/Library\/Developer\/CoreSimulator\/Devices\/3BC27151-469C-4E2E-A691-07DC943BB75C\/data",
        "dataPathSize" : 13312000,
        "logPath" : "\/Users\/username\/Library\/Logs\/CoreSimulator\/3BC27151-469C-4E2E-A691-07DC943BB75C",
        "udid" : "3BC27151-469C-4E2E-A691-07DC943BB75C",
        "isAvailable" : false,
        "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPad-mini-6th-generation",
        "state" : "Shutdown",
        "name" : "iPad mini (6th generation)"
      }
    ]
  }
}
"""#
