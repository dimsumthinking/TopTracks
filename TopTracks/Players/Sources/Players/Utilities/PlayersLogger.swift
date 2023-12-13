import OSLog

struct PlayersLogger {
  static let updatingSong = Logger(subsystem: "Players", category: "updating song")
  static let removingSong = Logger(subsystem: "Players", category: "removing song")
}
