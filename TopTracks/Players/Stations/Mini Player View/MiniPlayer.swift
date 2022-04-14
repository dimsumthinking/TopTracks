import SwiftUI
import MusicKit

struct MiniPlayer {
  let currentSong: Song?
  @ObservedObject private(set) var playerState = ApplicationMusicPlayer.shared.state
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying  
}

extension MiniPlayer: View {
  var body: some View {
    HStack {
      if let currentSong = currentSong {
        ZStack {
          Rectangle()
            .foregroundColor(.secondary.opacity(0.2))
            .frame(width: miniArtworkImageSize, height: miniArtworkImageSize, alignment: .center)
            .padding()
          if let artwork = TopTracksSong.artwork(for: currentSong) {
            ArtworkImage(artwork,
                         width: miniArtworkImageSize)
            .padding()
          }  else {
            if let artwork = currentSong.artwork {
            ArtworkImage(artwork,
                         width: miniArtworkImageSize)
            .padding()
            }
          }
        }
        VStack(alignment: .leading) {
          Text(currentSong.title)
          Text(currentSong.artistName)
            .font(.caption)
            .foregroundColor(.secondary)
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
      } else {
        Text("")
      }
    }
  }
}

struct MiniPlayer_Previews: PreviewProvider {
  static var previews: some View {
    MiniPlayer(currentSong: nil)
  }
}

//if let artwork = currentSong.artwork {

//ZStack {
//  Rectangle()
//    .foregroundColor(.secondary.opacity(0.2))
//    .frame(width: miniArtworkImageSize, height: miniArtworkImageSize, alignment: .center)
//    .padding()
//ArtworkImage(artwork,
//             width: miniArtworkImageSize)
//.padding()
//}
//}
