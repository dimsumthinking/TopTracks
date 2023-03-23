import Foundation

public let stationEssentialCategories: [RotationCategory] = [.power, .heavy, .medium, .light]
public let stationStandardCategories: [RotationCategory] = [.power, .heavy, .medium, .light, .gold]
public let stationExtendedCategories: [RotationCategory] = [.power, .heavy, .medium, .light, .gold, .added]
//let fullStationCreationCategories: [RotationCategory] = [.power, .heavy, .medium, .light, .gold, .recommended]

public enum RotationCategory: String, CaseIterable, Hashable, Equatable, Identifiable {
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
    return rawValue.uppercased()
  }
}
