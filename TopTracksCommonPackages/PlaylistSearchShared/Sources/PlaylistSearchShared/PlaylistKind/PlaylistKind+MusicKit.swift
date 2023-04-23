import MusicKit

extension PlaylistKind {
  public var isChart: Bool {
    switch self {
    case .cityCharts, .countryTop100, .top:
      return true
    default:
      return false
    }
  }
  
  public var hasHardCodedCategories: Bool {
    switch self {
    case .byGenre, .decade, .international, .moodAndActivity:
      return true
    default:
      return false
    }
  }
  
  public var musicCatalogChartKind: MusicCatalogChartKind {
    switch self {
    case .top: return .mostPlayed
    case .cityCharts: return .cityTop
    case .countryTop100: return .dailyGlobalTop
    default: fatalError("Type must be a chart type")
    }
  }
  
  public var playlistCategories: [AppleMusicCategory] {
    switch self {
    case .byGenre: return AppleMusicCategory.appleMusicGenres
    case .decade: return AppleMusicCategory.appleMusicDecades
    case .international: return AppleMusicCategory.appleMusicWorldwide
    case .moodAndActivity: return AppleMusicCategory.appleMusicMoodsAndActivities
    case .classical: return AppleMusicCategory.appleMusicClassical
    default: fatalError("Type must not be a chart type")
    }
  }
}
