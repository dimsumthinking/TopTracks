import MusicKit
import Foundation

struct NewStationSongRating: Identifiable {
  let song: Song
  var rating: Int
  
  var id: Int {
    song.hashValue
  }
}
