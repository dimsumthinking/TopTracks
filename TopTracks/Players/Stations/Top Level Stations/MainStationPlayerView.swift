import SwiftUI
import MusicKit

struct MainStationPlayerView {
  @State private var isShowingFullPlayer = false
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @State private var retrievedArtwork: Artwork?
}

extension MainStationPlayerView: View {
  var body: some View {
    VStack {
      if isShowingFullPlayer {
        FullPlayer(currentSong: currentSong,
                   retrievedArtwork: retrievedArtwork)
        .transition(.scale(scale: 0.05,
                           anchor: UnitPoint(x: 0.04,
                                             y: 0.98)))
        .contentShape(Rectangle())
        .onTapGesture {
          isShowingFullPlayer = false
        }
        .gesture(DragGesture().onChanged { _ in
          isShowingFullPlayer = false
        }
        )
      } else {
        StationsView()
        MiniPlayer(currentSong: currentSong,
                   retrievedArtwork: retrievedArtwork)
        .contentShape(Rectangle())
        .onTapGesture {
          isShowingFullPlayer = true
        }
      }
        
    }
    .animation( .easeInOut,
                value: isShowingFullPlayer)
  }
}

extension MainStationPlayerView {
  private var currentSong: Song? {
    guard let item =  queue.currentEntry?.item else {return nil}
    switch item {
    case .song(let innerSong):
      if let station = currentlyPlaying.station {
        station.markAsPlayed(songID: innerSong.id.rawValue)
        if station.stationType == .station && currentlyPlaying.song != innerSong {
          Task {
            retrievedArtwork = nil
            retrievedArtwork = try await ArtworkRetrieverFromAppleMusic.artwork(for: innerSong)
          }
        }
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
