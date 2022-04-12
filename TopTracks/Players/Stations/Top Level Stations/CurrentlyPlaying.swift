import Combine
import MusicKit

class CurrentlyPlaying: ObservableObject {
  @Published var station: TopTracksStation?
  var song: Song?
  @Published var hack: Bool = true
}

extension CurrentlyPlaying: Equatable {
  static func == (lhs: CurrentlyPlaying, rhs: CurrentlyPlaying) -> Bool {
    lhs.station == rhs.station
  }
  
  
}
