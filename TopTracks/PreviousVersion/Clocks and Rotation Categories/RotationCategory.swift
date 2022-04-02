let basicCategories: [RotationCategory] = [.power, .current, .added]
let standardRotationCategories: [RotationCategory] = [.power, .current, .added, .spice]
let selectableCategories: [RotationCategory] = [.power, .current, .added, .spice, .notIncluded]

enum RotationCategory: String, CaseIterable, Equatable, Hashable, Codable {
  case power
  case current
  case added
  case spice
  case recommended
  case notIncluded
}

extension RotationCategory: CustomStringConvertible {
  var description: String {
    switch self {
    case .power: return "Top Tracks"
    case .current: return "Recent Favorites"
    case .added: return "Newly Added"
    case .spice: return "Extra Spice"
    case .recommended: return "Recommended"
    case .notIncluded: return "Not Included"
    }
  }
}
extension RotationCategory {
  var rotationLevel: String {
    switch self {
    case .power: return "Top Tracks"
    case .current: return "Heavy Rotation"
    case .added: return "Medium Rotation"
    case .spice: return "Light Rotation"
    case .recommended: return ""
    case .notIncluded: return ""
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
    case .notIncluded: return .primary
    }
  }
}

extension RotationCategory {
  var symbol: Image {
    switch self {
    case .power: return Image(systemName: "star")
    case .current: return Image(systemName: "heart")
    case .added: return Image(systemName: "plus")
    case .spice:  return Image(systemName: "bolt")
    case .recommended: return  Image(systemName: "text.bubble")
    case .notIncluded: return Image(systemName: "circle.slash")
    }
  }
  
  var likeability: String {
    switch self {
    case .power: return "I love it"
    case .current: return "Really good"
    case .added: return "Pretty Nice"
    case .spice: return "It's just OK"
    case .recommended: return  "N/A"
    case .notIncluded: return "Not for me"
    }
  }
}

extension RotationCategory: Comparable {
  static func < (lhs: RotationCategory, rhs: RotationCategory) -> Bool {
    lhs.value < rhs.value
  }
  
  var value: Int {
    switch self {
    case .power: return 0
    case .current: return 1
    case .added: return 2
    case .spice: return 3
    case .recommended: return 4
    case .notIncluded: return 5
    }
  }
  
  var next: RotationCategory {
    switch self {
    case .power: return .current
    case .current: return .added
    case .added: return .spice
    default: return .notIncluded
    }
  }
  var hasNext: Bool {
    next != .notIncluded
  }  
}
