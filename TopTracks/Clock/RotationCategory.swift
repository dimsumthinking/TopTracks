let standardCategories: [RotationCategory] = [.power, .current, .added]
let expandedCategories: [RotationCategory] = [.power, .current, .added, .spice]

enum RotationCategory: String, CaseIterable, Equatable, Hashable, Codable {
  case power
  case current
  case added
  case spice
  case recommended
}

extension RotationCategory: CustomStringConvertible {
  var description: String {
    switch self {
    case .power: return "Top Tracks"
    case .current: return "Recent Favorites"
    case .added: return "Newly Added"
    case .spice: return "Extra Spice"
    case .recommended: return "Recommended"
    }
  }
}

extension RotationCategory {
  var capacity: Int {
    switch self {
    case .spice: return 500
    default: return 12
    }
  }
}

import Foundation

extension RotationCategory: Identifiable {
  var id: Int {
    self.hashValue
  }
}

import SwiftUI

extension RotationCategory {
  var color: Color {
    switch self {
    case .power: return .red
    case .current: return .purple
    case .added: return .mint
    case .spice:  return .orange
    case .recommended: return  Color(red: 1, green: 0.85, blue: 0)
    }
  }
}
