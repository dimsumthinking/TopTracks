enum TopTracksStationType {
  case chart
  case playlist
}

extension TopTracksStationType {
  var blurb: String {
    switch self {
    case .chart:
      return "Updated daily from selected\nApple Music Chart"
    case .playlist:
      return "Hand-crafted from curated\nApple Music Playlist"
    }
  }
}

extension TopTracksStationType {
  var imageName: String {
    switch self {
    case .chart:
      return appleMusicChartIcon
    case .playlist:
      return appleMusicPlaylistIcon
    }
  }
}
