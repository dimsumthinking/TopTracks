import Foundation
import SwiftUI
import MusicKit


func color(from cgColor: CGColor?,
           or backup: Color) -> Color {
  guard let cgColor = cgColor else {return backup}
  return Color(cgColor)
}

//func color(from cgColor: CGColor?,
//           or backup: UIColor) -> Color {
//  guard let cgColor = cgColor else {return Color(backup)}
//  return Color(cgColor)
//}


func color(from cgColor: CGColor?,
           or backup: UIColor) -> Color {
  let amount = 0.9
  guard let cgColor = cgColor else {return Color(backup)}
        let color1 = CIColor(color: UIColor(cgColor: cgColor))
        let color2 = CIColor(color: backup)
  
  return Color(red: amount * color1.red + (1 - amount) * color2.red,
               green: amount * color1.green + (1 - amount) * color2.green,
               blue: amount * color1.blue + (1 - amount) * color2.blue)
}


