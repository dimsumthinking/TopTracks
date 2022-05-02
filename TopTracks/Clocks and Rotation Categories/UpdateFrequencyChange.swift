enum UpdateFrequencyChange: Int {
  case moreOften = 1
  case theSame = 0
  case lessOften = -1
}

extension UpdateFrequencyChange {
  var imageName: String {
    switch self {
    case .moreOften: return "heart.fill"
    case .theSame: return "heart"
    case .lessOften: return "heart.slash"
    }
  }
}

extension UpdateFrequencyChange {
  var decrease: UpdateFrequencyChange {
    switch self {
    case .moreOften: return .theSame
    default: return .lessOften
    }
  }
  var increase: UpdateFrequencyChange {
    switch self {
    case .lessOften: return .theSame
    default: return .moreOften
    }
  }
}
