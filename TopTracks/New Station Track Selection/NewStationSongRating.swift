import MusicKit
import Foundation

struct NewStationSongRating: Identifiable, Equatable {
  let song: Song
  var rating: Int
  var rotationCategory: RotationCategory = .spice
  var id: Int {
    song.hashValue
  }
}
