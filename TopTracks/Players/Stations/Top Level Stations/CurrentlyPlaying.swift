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

extension CurrentlyPlaying {
  var topTracksSong: TopTracksSong? {
    guard let station = station,
          let song = song else {return nil}
    return station.song(with: song.id)
  }
}
