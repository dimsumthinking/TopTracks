enum RotationCategory: String, CaseIterable {
  case power = "Top Tracks"
  case current = "Recent Favorites"
  case added = "Newly Added"
  case gold = "Solid Gold"
}

extension RotationCategory: CustomStringConvertible {
  var description: String {
    rawValue
  }
}

extension RotationCategory {
  var capacity: Int {
    switch self {
    case .gold: return 500
    default: return 11
    }
  }
}
