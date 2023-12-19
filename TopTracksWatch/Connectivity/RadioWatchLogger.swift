import OSLog

struct RadioWatchLogger {
  static let connecting = Logger(subsystem: "RadioWatch", category: "connecting")
  static let selectingStation = Logger(subsystem: "RadioWatch", category: "selecting station")
  static let selectingAndPlayingStation = Logger(subsystem: "RadioWatch", category: "selecting and playing station")
  static let receivingStations = Logger(subsystem: "RadioWatch", category: "receiving stations")
  static let sendingStations = Logger(subsystem: "RadioWatch", category: "sending stations")
  static let sendingSelectedStation = Logger(subsystem: "RadioWatch", category: "sending selected station")
  static let sendingAndPlayingSelectedStation = Logger(subsystem: "RadioWatch", category: "sending and playing selected station")

  static let requestingStationList = Logger(subsystem: "RadioWatch", category: "requesting Station List")

}
