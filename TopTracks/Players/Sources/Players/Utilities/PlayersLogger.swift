import OSLog

public struct PlayersLogger {
  public static let updatingSong = Logger(subsystem: "Players", category: "updating song")
  public static let removingSong = Logger(subsystem: "Players", category: "removing song")
}
