enum RotationClock: Codable {
  case standardHour
  case hourWithRecommendations
  case shortHourWithRecommendations
  case hourWithSpice
  case shortHourWithSpice
  case hourWithSpiceAndRecommendations
  case shortHourWithSpiceAndRecommendations
}

extension RotationClock {
  var slots: [RotationCategory] {
    switch self {
    case .standardHour:
      return [.power, .current, .added,
              .power, .current,
              .power, .added,
              .power, .current,
              .power, .added,
              .power, .current]
    case .hourWithRecommendations:
      return [.power, .current, .added,
              .power, .current, .recommended,
              .power, .added,
              .power, .current, .recommended,
              .power, .added,
              .power, .current]
    case .shortHourWithRecommendations:
      return [.power, .current, .added,
              .power, .current,
              .power, .added,
              .power, .current, .recommended,
              .power, .added,
              .power, .current]
    case .hourWithSpice:
      return [.power, .current, .added,
              .power, .current,
              .power, .added, .spice,
              .power, .current,
              .power, .added,
              .power, .current, .spice]
    case .shortHourWithSpice:
      return [.power, .current, .added,
              .power, .current,
              .power, .added, .spice,
              .power, .current,
              .power, .added,
              .power, .current]
      
    case .hourWithSpiceAndRecommendations:
      return [.power, .current, .added,
              .power, .current, .recommended,
              .power, .added, .spice,
              .power, .current, .recommended,
              .power, .added,
              .power, .current, .spice]
    case .shortHourWithSpiceAndRecommendations:
      return [.power, .current, .added,
              .power, .current, .spice,
              .power, .added,
              .power, .current,
              .power, .added, .recommended,
              .power, .current]
    }
  }
}
