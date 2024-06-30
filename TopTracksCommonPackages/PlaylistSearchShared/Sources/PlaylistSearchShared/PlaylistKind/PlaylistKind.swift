import Foundation

public let mainPlaylistKinds = [PlaylistKind.top, .cityCharts, .countryTop100, .byGenre, .moodAndActivity, .decade, .international, .openSearch]

public enum PlaylistKind: String, CaseIterable, Hashable, Equatable, Sendable {
  case top
  case cityCharts
  case countryTop100
  case byGenre
  case moodAndActivity
  case decade
  case international
  case classical
  case openSearch
}

extension PlaylistKind {
  public var sfSymbolName: String {
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
    case .openSearch:
      return "magnifyingglass"
    }
  }
}

extension PlaylistKind: CustomStringConvertible {
  public var description: String {
    switch self {
    case .top:
      return "Top Playlists"
    case .cityCharts:
     return "City Charts Top 25"
    case .countryTop100:
      return "Daily Global Top 100"
    case .byGenre:
      return "Top Genres"
    case .moodAndActivity:
      return "Mood and Activity"
    case .decade:
      return "The Decades"
    case .international:
      return "International Music"
    case .classical:
      return "Classical"
    case .openSearch:
      return "Open Search"
    }
  }
}

extension PlaylistKind: Identifiable {
  public var id: Self {
    self
  }
}
