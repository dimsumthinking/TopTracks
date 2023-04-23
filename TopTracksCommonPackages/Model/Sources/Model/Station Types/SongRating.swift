public enum SongRating: String, CaseIterable, Hashable, Equatable {
  case topTrack
  case love
  case like
  case neutral
  case dontLike
  case remove
}

extension SongRating: Comparable {
  public static func < (lhs: SongRating,
                        rhs: SongRating) -> Bool {
    lhs.index > rhs.index
  }
  
  private var index: Int {
    SongRating.allCases.firstIndex(of: self) ?? 0
  }
}

extension SongRating: CustomStringConvertible {
  public var name: String {
    switch self {
    case .topTrack: return  "I love it"
    case .love: return "Play it more"
    case .like: return "I like it"
    case .neutral: return "It's ok"
    case .dontLike: return "Play it less"
    case .remove: return "Don't play it again"
    }
  }
  public var description: String {
    return rawValue
  }
}

extension SongRating {
  public var icon: String {
    switch self {
    case .topTrack: return "bolt.heart.fill"
    case .love: return "arrow.up.heart.fill"
    case .like: return "heart.fill"
    case .neutral: return "heart"
    case .dontLike: return "arrow.down.heart"
    case .remove: return "heart.slash"
    }
  }
}
