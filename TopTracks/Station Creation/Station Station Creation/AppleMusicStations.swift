import Foundation

let appleMusicStations = AppleMusicStations.allCases

enum AppleMusicStations: String, CaseIterable {
  case alternativeAndIndie = "Alternative & Indie"
  case christian
  case classical
  case country
  case dance
  case electronic
  case fromAroundTheWorld = "From Around the World"
  case hipHopAndRAndB = "Hip-Hop/R&B"
  case hitsByDecade = "Hits by Decade"
  case holiday
  case jazz
  case kidsAndFamily = "Kids & Family"
  case latin
  case metal
  case pop
  case reggae
  case rock
  case singerAndSongwritier = "Singer/Songwriter"
}

extension AppleMusicStations: Identifiable {
  var id: Self {
    self
  }
}


extension AppleMusicStations: CustomStringConvertible {
  var description: String {
    rawValue.first!.isLetter ? rawValue.capitalized : rawValue
    
  }
}
