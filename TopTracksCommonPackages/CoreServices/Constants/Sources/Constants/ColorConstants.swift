
import SwiftUI

public enum ColorConstants {}

extension ColorConstants {
  public static func accentColor(for colorScheme: ColorScheme) -> Color {
    switch colorScheme {
    case .light:
      return .pink
    default:
      return .yellow
    }
  }
  
  public static func gradientStartColor(backgroundColor: CGColor,
                                        colorScheme: ColorScheme) -> Color {
    switch colorScheme {
    case .light:
      return Color(backgroundColor).opacity(0.1)
    default:
      return Color(backgroundColor).opacity(0.8)
    }
  }
  
  public static func gradientEndColor(backgroundColor: CGColor,
                                        colorScheme: ColorScheme) -> Color {
    switch colorScheme {
    case .light:
      return Color(backgroundColor).opacity(0.4)
    default:
      return Color(backgroundColor).opacity(0.2)
    }
  }
  
  public static func color(for stationName: String) -> CGColor {
    var stationName = stationName.lowercased().trimmingCharacters(in: .lowercaseLetters.inverted)
    let first = stationName.removeFirst()
    let _ = stationName.removeFirst()
    let second = stationName.removeFirst()
    let _ = stationName.removeFirst()
    let third = stationName.removeFirst()
    return CGColor(red: float(for: first),
                   green: float(for: second),
                   blue: float(for: third),
                   alpha: 1.0)
    
  }
  
  private static func float(for letter: Character) -> Double {
    guard let ascii = letter.asciiValue else {return 1.0}
    return Double(ascii - 97)/26
  }
}
