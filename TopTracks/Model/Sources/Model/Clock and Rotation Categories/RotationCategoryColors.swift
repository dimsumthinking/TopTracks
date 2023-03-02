import SwiftUI

extension RotationCategory {
  var color: Color {
    switch self {
    case .power: return .red
    case .heavy: return .purple
    case .medium: return .mint
    case .light: return .yellow
    case .gold: return .orange
    case .recommended, .recommendedPlayed: return .green
    default: return .brown
    }
  }
}
