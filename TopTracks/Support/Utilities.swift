import Foundation
import SwiftUI
import MusicKit


func color(from cgColor: CGColor?,
           or backup: Color) -> Color {
  guard let cgColor = cgColor else {return backup}
  return Color(cgColor)
}

func color(from cgColor: CGColor?,
           or backup: UIColor) -> Color {
  guard let cgColor = cgColor else {return Color(backup)}
  return Color(cgColor)
}


