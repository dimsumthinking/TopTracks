import OSLog

struct PlayersTVLogger {
  static let updatingSong = Logger(subsystem: "PlayersTV", category: "updating song")
  static let removingSong = Logger(subsystem: "Players", category: "removing song")

}
