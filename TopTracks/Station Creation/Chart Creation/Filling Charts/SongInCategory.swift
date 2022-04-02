import MusicKit
import Foundation

struct SongInCategory: Equatable {
  let song: Song
  var rotationCategory: RotationCategory
  
  init(for song: Song,
       rotationCategory: RotationCategory = .notIncluded) {
    self.song = song
    self.rotationCategory = rotationCategory
  }
  static func ==(lhs: SongInCategory, rhs: SongInCategory) -> Bool {
    lhs.song == rhs.song
  }
}

extension SongInCategory: Identifiable {
  var id: Int {
    song.hashValue
  }
}
