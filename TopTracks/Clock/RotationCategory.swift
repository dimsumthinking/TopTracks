let standardCategories: [RotationCategory] = [.power, .current, .added, .gold]

enum RotationCategory: String, CaseIterable, Equatable, Hashable, Codable {
  case power = "Top Tracks"
  case current = "Recent Favorites"
  case added = "Newly Added"
  case gold = "Solid Gold"
  case spice = "Extra Spice"
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
    default: return 11
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
    case .gold: return  Color(red: 1, green: 0.85, blue: 0)
    case .spice: return .orange
    }
  }
}
