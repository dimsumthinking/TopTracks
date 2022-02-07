let standardCategories: [RotationCategory] = [.power, .current, .added]

enum RotationCategory: String, CaseIterable, Equatable, Hashable, Codable {
  case power = "Top Tracks"
  case current = "Recent Favorites"
  case added = "Newly Added"
  case spice = "Extra Spice"
  case recommended = "Recommended"
}

extension RotationCategory: CustomStringConvertible {
  var description: String {
    rawValue
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
    case .spice: return  Color(red: 1, green: 0.85, blue: 0)
    case .recommended: return .orange
    }
  }
}
