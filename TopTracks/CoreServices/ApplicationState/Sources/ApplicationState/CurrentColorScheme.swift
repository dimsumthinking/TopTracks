import SwiftUI

public enum CurrentColorScheme: String, CaseIterable {
  case system
  case dark
  case light
}

extension CurrentColorScheme {
  public var index: Int {
    switch self {
    case .system: return 0
    case .dark: return 1
    case .light: return 2
    }
  }
}

extension CurrentColorScheme: Identifiable {
  public var id: Int {
    index
  }
}

public func currentColorScheme(from string: String) -> ColorScheme? {
  switch string {
  case "system": return nil
  case "light": return .light
  default: return .dark
  }
}

public func indexForColorScheme(from string: String) -> Int {
  switch string {
  case "system": return 0
  case "light": return 2
  default: return 1
  }
}
