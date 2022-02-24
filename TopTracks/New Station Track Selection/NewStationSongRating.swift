import MusicKit
import Foundation

struct NewStationSongRating: Identifiable, Equatable {
  let song: Song
  var rating: Int
  var rotationCategory: RotationCategory = .notIncluded
}

extension NewStationSongRating {
  var id: Int {
    song.hashValue
  }
}
