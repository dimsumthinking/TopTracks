import OSLog

struct StationUpdatersLogger {
  static let updatingPlaylist = Logger(subsystem: "Model",
                                       category: "updating playlist")
  static let updatingChart = Logger(subsystem: "Model",
                                    category: "updating chart")
}
