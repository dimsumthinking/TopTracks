
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
}
