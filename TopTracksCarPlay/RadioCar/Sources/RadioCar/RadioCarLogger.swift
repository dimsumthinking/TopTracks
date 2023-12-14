import OSLog

struct RadioCarLogger {
  static let fetchingStations = Logger(subsystem: "RadioCar",
                                       category: "fetching stations")
  static let playingStation = Logger(subsystem: "RadioCar",
                                       category: "playing station")

}
