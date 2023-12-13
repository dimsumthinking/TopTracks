import OSLog

struct RadioLoggerTV {
  static let playing = Logger(subsystem: "Radio", category: "playing")
  static let stationDelete = Logger(subsystem: "Radio", category: "Station Delete")
  static let stationOrder = Logger(subsystem: "Radio", category: "Station Order")
  static let stationNameChange = Logger(subsystem: "Radio", category: "Station Name Change")
  static let stationMusicRotator = Logger(subsystem: "Radio", category: "Station Music Rotator")
}
