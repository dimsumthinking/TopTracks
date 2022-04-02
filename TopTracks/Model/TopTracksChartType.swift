enum TopTracksChartType {
  case topSongs
  case cityCharts
  case dailyTop100
  case playlists
}

extension TopTracksChartType {
  var blurb: String {
    switch self {
    case .topSongs:
      return "Top Songs\n(by Genre)"
    case .cityCharts:
      return "City Charts\n(Top 25)"
    case .dailyTop100:
      return "Daily Top 100\n(by Country)"
    case .playlists:
      return "Top Playlists\n(Top 100)"
    }
  }
}

extension TopTracksChartType {
  var imageName: String {
    switch self {
    case .topSongs:
      return "music.note.list"
    case .cityCharts:
      return "mappin"
    case .dailyTop100:
      return "map"
    case .playlists:
      return "square.stack.3d.up"
    }
  }
}



