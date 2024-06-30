import Foundation

public let stationEssentialCategories: [RotationCategory] = [.power, .heavy, .medium, .light]
public let stationStandardCategories: [RotationCategory] = [.power, .heavy, .medium, .light, .gold]
public let stationExtendedCategories: [RotationCategory] = [.power, .heavy, .medium, .light, .gold, .added]
//let fullStationCreationCategories: [RotationCategory] = [.power, .heavy, .medium, .light, .gold, .recommended]

public enum RotationCategory: String, CaseIterable, Hashable, Equatable, Identifiable, Sendable {
  case power
  case heavy
  case medium
  case light
  case gold
  case added
  case archived
  case removed
//  case recommended
//  case recommendedPlayed
}



extension RotationCategory {
  public var frequency: String {
    switch self {
    case .power: return "90 minutes"
    case .heavy: return "2 1/2 hours"
    case .medium: return "3 1/2 hours"
    case .light:  return "5 hours"
    case .gold:  return "rarely"
    case .added: return "not added yet"
    default: return "never"
    }
  }
  
  public var numberPerHour: Int {
    switch self {
    case .power: return 6
    case .heavy: return 4
    case .medium: return 3
    case .light:  return 2
    case .gold:  return 1
    default: return 0
    }
  }
}


extension RotationCategory {
  public var id: Int {
    hashValue
  }
}

extension RotationCategory: Comparable {
  public static func < (lhs: RotationCategory,
                        rhs: RotationCategory) -> Bool {
    lhs.index < rhs.index
  }
  
  
  private var index: Int {
    RotationCategory.allCases.firstIndex(of: self) ?? 0
  }
  
}

extension RotationCategory: CustomStringConvertible {
  var name: String {
    return rawValue
  }
  public var description: String {
    return rawValue.capitalized
  }
}
