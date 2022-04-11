import SwiftUI
import MusicKit

struct MainStationPlayerView {
  @State private var isShowingFullPlayer = false
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
}

extension MainStationPlayerView: View {
  var body: some View {
    VStack {
      StationsView()
      MiniPlayer(currentSong: currentSong)
        .contentShape(Rectangle())
        .onTapGesture {
          isShowingFullPlayer = true
        }
    }
    .sheet(isPresented: $isShowingFullPlayer) {
    FullPlayer(currentSong: currentSong)
    }
  }
}

extension MainStationPlayerView {
  private var currentSong: Song? {
    guard let item =  queue.currentEntry?.item else {return nil}
    switch item {
    case .song(let innerSong):
      if let station = currentlyPlaying.station {
      station.markAsPlayed(songID: innerSong.id.rawValue)
      }
      currentlyPlaying.song = innerSong
      return innerSong
    default:
      return nil
    }
  }
}


struct MainStationPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    MainStationPlayerView()
  }
}
