enum RotationClock: Codable {
  case standardHour
  case shortHour
  case spiceHour
  case shortSpiceHour
}

extension RotationClock {
  var slots: [RotationCategory] {
    switch self {
    case .standardHour:
      return [.power, .current, .added,
              .power, .current, .gold,
              .power, .added,
              .power, .current,
              .power, .added,
              .power, .current, .gold]
    case .shortHour:
      return [.power, .current, .added,
              .power, .current,
              .power, .added,
              .power, .current,
              .power, .added,
              .power, .current]
    case .spiceHour:
      return [.power, .current, .added,
              .power, .current, .gold,
              .power, .added,
              .power, .current, .spice,
              .power, .added,
              .power, .current, .gold]
    case .shortSpiceHour:
      return [.power, .current, .added,
              .power, .current,
              .power, .added,
              .power, .current, .spice,
              .power, .added,
              .power, .current]
    }
  }
}
