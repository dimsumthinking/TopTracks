import SwiftUI
import MusicKit

struct FullPlayer {
  let currentSong: Song?
  @ObservedObject private(set) var playerState = ApplicationMusicPlayer.shared.state
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
  let retrievedArtwork: Artwork?
}

extension FullPlayer: View {
  var body: some View {
    VStack {
      if topTracksStatus.isNotConnected {
       OfflineWarningView()
      }
      if let stationName = currentlyPlaying.station?.stationName {
        Text(stationName)
          .padding()
      }
      
      if let currentSong = currentSong {
        PlayerArtwork(song: currentSong,
                      size: fullArtworkImageSize,
                      retrievedArtwork: retrievedArtwork)
        
        Text(currentSong.title)
          .multilineTextAlignment(.center)
          .foregroundColor(.secondary)
          .font(.title2)
        Text(currentSong.artistName)
          .multilineTextAlignment(.center)
          .foregroundColor(.secondary)
        Spacer()
        SongScrubberView(currentSong: currentSong)
      }
      Spacer()
      
      HStack {
        Spacer()
        Button(action: {
          Task{try await stationSongPlayer.skipToPreviousEntry()}}){
            Image(systemName: "backward.fill")
          }
        Spacer()
        switch(playerState.playbackStatus) {
        case .playing:
          Button {
            stationSongPlayer.pause(currentlyPlaying.station,
                                    at: currentlyPlaying.song)
            
          } label: {
            Image(systemName: "pause.fill")
              .font(.largeTitle)
              .padding()
          }
        default:
          Button {
            Task {
              try await stationSongPlayer.restart()
            }
          } label: {
            Image(systemName: "play.fill")
              .font(.largeTitle)
              .padding()
          }
        }
        Spacer()
        Button(action: {Task{try await stationSongPlayer.skipToNextEntry()}}){
          Image(systemName: "forward.fill")
        }
        Spacer()
      }
      .font(.title)
      .foregroundColor(.primary)
      .padding(.vertical)
      SystemVolumeSlider()
        .frame(height: 20)
        .padding()
        .accentColor(.secondary)
        .padding(.horizontal)
      //      }
      
    }
  }
}

//struct FullPlayer_Previews: PreviewProvider {
//  static var previews: some View {
//    FullPlayer()
//  }
//}
