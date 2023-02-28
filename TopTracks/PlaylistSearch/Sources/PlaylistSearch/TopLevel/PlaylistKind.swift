import Foundation

enum PlaylistKind: String, CaseIterable {
  case top
  case cityCharts
  case countryTop100
  case byGenre
  case moodAndActivity
  case decade
  case international
}

extension PlaylistKind {
  var sfSymbolName: String {
    switch self {
    case .top:
      return "chart.line.uptrend.xyaxis"
    case .cityCharts:
      return "mappin.and.ellipse"
    case .countryTop100:
      return "map"
    case .byGenre:
      return "music.note.list"
    case .moodAndActivity:
      return "person.crop.rectangle.stack"
    case .decade:
      return "calendar"
    case .international:
      return "globe"
    }
  }
}

extension PlaylistKind: CustomStringConvertible {
  var description: String {
    switch self {
    case .top:
      return "Top Playlists"
    case .cityCharts:
     return "City Charts Top 25"
    case .countryTop100:
      return "Daily Global Top 100"
    case .byGenre:
      return "Playlists by Genre"
    case .moodAndActivity:
      return "Mood and Activity"
    case .decade:
      return "The Decades"
    case .international:
      return "International Music"
    }
  }
}

extension PlaylistKind: Identifiable {
  var id: Self {
    self
  }
}


import MusicKit

extension PlaylistKind {
  var isChart: Bool {
    switch self {
    case .cityCharts, .countryTop100, .top:
      return true
    default:
      return false
    }
  }
  
  var musicCatalogChartKind: MusicCatalogChartKind {
    switch self {
    case .top: return .mostPlayed
    case .cityCharts: return .cityTop
    case .countryTop100: return .dailyGlobalTop
    default: fatalError("Type must be a chart type")
    }
  }
  
  var playlistCategories: [AppleMusicCategory] {
    switch self {
    case .byGenre: return AppleMusicCategory.appleMusicGenres
    case .decade: return AppleMusicCategory.appleMusicDecades
    case .international: return AppleMusicCategory.appleMusicWorldwide
    case .moodAndActivity: return AppleMusicCategory.appleMusicMoodsAndActivities
    default: fatalError("Type must not be a chart type")
    }
  }
}
