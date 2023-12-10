import OSLog

struct RadioLogger {
  static let playing = Logger(subsystem: "Radio", category: "playing")
  static let stationDelete = Logger(subsystem: "Radio", category: "Station Delete")
  static let stationOrder = Logger(subsystem: "Radio", category: "Station Order")
  static let stationNameChange = Logger(subsystem: "Radio", category: "Station Name Change")

}
