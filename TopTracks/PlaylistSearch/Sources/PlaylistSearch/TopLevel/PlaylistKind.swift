import Foundation

let mainPlaylistKinds = [PlaylistKind.top, .cityCharts, .countryTop100, .byGenre, .moodAndActivity, .decade, .international]

enum PlaylistKind: String, CaseIterable, Hashable, Equatable {
  case top
  case cityCharts
  case countryTop100
  case byGenre
  case moodAndActivity
  case decade
  case international
  case classical
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
    case .classical:
      return "headphones"
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
    case .classical:
      return "Classical"
    }
  }
}

extension PlaylistKind: Identifiable {
  var id: Self {
    self
  }
}
