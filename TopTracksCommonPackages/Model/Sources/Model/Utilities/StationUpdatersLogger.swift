import OSLog

struct StationUpdatersLogger {
  static let updatingPlaylist = Logger(subsystem: "Model",
                                       category: "updating playlist")
  static let updatingChart = Logger(subsystem: "Model",
                                    category: "updating chart")
  static let rotatingStation = Logger(subsystem: "Model",
                                      category: "rotating station")
  static let addingSongsToStation = Logger(subsystem: "Model",
                                           category: "adding songs to station")
  static let changedSongRating = Logger(subsystem: "Model",
                                        category: "changed song rating")
  static let markingSongAsPlayed = Logger(subsystem: "Model",
                                          category: "marking song as played")
  static let markingStationAsPlayed = Logger(subsystem: "Model",
                                             category: "marking station as played")
  static let removingSong = Logger(subsystem: "Model",
                                   category: "removing song")
}
