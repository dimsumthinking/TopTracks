import SwiftUI

extension RotationCategory {
  public var color: Color {
    switch self {
    case .power: return .red
    case .heavy: return .purple
    case .medium: return .mint
    case .light: return .orange
    case .gold: return .yellow
//    case .recommended, .recommendedPlayed: return .green
    default: return .brown
    }
  }
}

extension RotationCategory {
  public var icon: String {
    switch self {
    case .power: return "bolt"
    case .heavy: return "star"
    case .medium: return "checkmark"
    case .light: return "light.min"
    case .gold: return "dollarsign.bank.building"
    case .archived: return "archivebox"
//    case .recommended, .recommendedPlayed: return "text.bubble"
    case .added: return "plus"
    default: return "trash"
    }
  }
}

