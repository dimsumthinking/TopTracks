import Combine
import MusicKit

class CurrentlyPlaying: ObservableObject {
  @Published var station: TopTracksStation?
  var song: Song?
}
