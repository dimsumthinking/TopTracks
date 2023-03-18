public enum SongMotion: String, CaseIterable, Hashable, Equatable {
  case down
  case added
  case up
}

extension SongMotion {
  private var index: Int {
    SongMotion.allCases.firstIndex(of: self) ?? 0
  }
}

extension SongMotion: CustomStringConvertible {
  var name: String {
    return rawValue
  }
  public var description: String {
    return rawValue
  }
}

extension SongMotion {
  var icon: String {
    switch self {
    case .down: return "arrow.down"
    case .added: return "plus"
    case .up: return "arrow.up"
    }
  }
}
