import SwiftUI

extension RotationCategory {
  var color: Color {
    switch self {
    case .power: return .red
    case .heavy: return .purple
    case .medium: return .mint
    case .light: return .yellow
    case .gold: return .orange
//    case .recommended, .recommendedPlayed: return .green
    default: return .brown
    }
  }
}

extension RotationCategory {
  var icon: String {
    switch self {
    case .power: return "bolt"
    case .heavy: return "star"
    case .medium: return "checkmark"
    case .light: return "ellipsis.curlybraces"
    case .gold: return "archivebox"
//    case .recommended, .recommendedPlayed: return "text.bubble"
    case .added: return "plus"
    case .removed: return "minus"
    default: return "questionmark"
    }
  }
}

