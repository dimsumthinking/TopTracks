let stationEssentialCategories: [RotationCategory] = [.power, .heavy, .medium, .light]
let stationCreationCategories: [RotationCategory] = [.power, .heavy, .medium, .light, .gold]

public enum RotationCategory: String, CaseIterable, Hashable, Equatable {
  case power
  case heavy
  case medium
  case light
  case gold
  case archived
  case notIncluded
  case removed
  case recommended
  case recommendedPlayed
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
    return rawValue
  }
}
