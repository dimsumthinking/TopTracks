import MusicKit
import Foundation

class MusicTestResult: Equatable {
  let song: Song
  var rotationcategory: RotationCategory = .notIncluded
  
  init(for song: Song) {
    self.song = song
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



