public enum SongMotion: String, CaseIterable, Hashable, Equatable {
  case downPlus
  case down
  case same
  case up
  case upPlus
  case added
}

extension SongMotion: Comparable {
  public static func < (lhs: SongMotion,
                        rhs: SongMotion) -> Bool {
    lhs.index < rhs.index
  }
  private var index: Int {
    SongMotion.allCases.firstIndex(of: self) ?? 0
  }
}

extension SongMotion: CustomStringConvertible {
  var name: String {
    return rawValue
  }
  public var description: String {
    return rawValue.uppercased()
  }
}

//extension SongMotion {
//  var icon: String {
//    switch self {
//    case .down: return "arrow.left"
//    case .added: return "plus"
//    case .up: return "arrow.right"
//    case .same: return "minus"
//      case
//    }
//  }
//}
