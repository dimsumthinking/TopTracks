import OSLog

struct ManualUpdateStationLogger {
  static let changingSongCategory = Logger(subsystem: "PlaylistSongPreview",
                                       category: "changing song category")
}
