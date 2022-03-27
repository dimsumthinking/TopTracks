import MusicKit
import Foundation

struct MusicTestResult: Equatable {
  let song: Song
  var rotationCategory: RotationCategory
  
  init(for song: Song,
       rotationCategory: RotationCategory = .notIncluded) {
    self.song = song
    self.rotationCategory = rotationCategory
  }
  static func ==(lhs: MusicTestResult, rhs: MusicTestResult) -> Bool {
    lhs.song == rhs.song
  }
}

extension MusicTestResult: Identifiable {
  var id: Int {
    song.hashValue
  }
}



