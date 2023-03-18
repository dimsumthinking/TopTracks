public enum SongRating: String, CaseIterable, Hashable, Equatable {
  case topTrack
  case love
  case like
  case neutral
  case dontLike
  case remove
}

extension SongRating {
  private var index: Int {
    SongRating.allCases.firstIndex(of: self) ?? 0
  }
}

extension SongRating: CustomStringConvertible {
  public var name: String {
    switch self {
    case .topTrack:
      "I love it"
    case .love:
      "Play it more"
    case .like:
      "I like it"
    case .neutral:
      "It's ok"
    case .dontLike:
      "Play it less"
    case .remove:
      "Don't play it again"
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
