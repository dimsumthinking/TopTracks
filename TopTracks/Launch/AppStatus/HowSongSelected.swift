enum HowSongSelected {
  case back
  case normal
  case forward
}

extension HowSongSelected {
  var increment: Int {
    switch self {
    case .back: return -1
    case .normal: return 0
    case .forward: return 1
    }
  }
}
