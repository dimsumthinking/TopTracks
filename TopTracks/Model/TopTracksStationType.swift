enum TopTracksStationType {
  case chart(chartType: TopTracksChartType)
  case playlist
  case station
}

extension TopTracksStationType {
  var host: String {
    switch self {
    case .playlist:
      return "playlist"
    case .station:
      return "station"
    case .chart(let chartType):
      switch chartType {
      case .topSongs:
        return "topSongs"
      case .dailyTop100:
        return "dailyTop100"
      case .cityCharts:
        return "cityCharts"
      case .playlists:
        return "playlist"
      }
    }
  }
}

extension TopTracksStationType {
  static func stationType(from host: String) -> TopTracksStationType? {
    switch host {
    case "playlist":
      return .playlist
    case "station":
      return .station
    case "topSongs":
      return .chart(chartType: .topSongs)
    case "dailyTop100":
      return .chart(chartType: .dailyTop100)
    case "cityCharts":
      return .chart(chartType: .cityCharts)
    default:
      return stationTypeForDeepLinkNotFound
    }
  }
}

extension TopTracksStationType {
  var updatesDaily: Bool {
    switch self {
    case .chart(let chartType):
      return chartType != .playlists
    default:
      return false
    }
  }
}

extension TopTracksStationType: Equatable {
  static func ==(lhs: TopTracksStationType, rhs: TopTracksStationType) -> Bool {
    switch (lhs, rhs) {
    case (.playlist, .playlist), (.station, .station):
      return true
    case (.chart(let lhsChartType), .chart(let rhsChartType)):
      return lhsChartType == rhsChartType
    default:
      return false
    }
  }
}
