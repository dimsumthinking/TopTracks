import SwiftUI
import Constants
import ApplicationState
import MusicKit

struct MiniPlayerView {
  @EnvironmentObject private var applicationState: ApplicationState
}


extension MiniPlayerView: View {
  var body: some View {
    if let currentSong = applicationState.currentSong {
      HStack(spacing: 4) {
        if let artwork = currentSong.storedArtwork {
          ArtworkImage(artwork,
                       width: Constants.miniPlayerArtworkImageSize,
                       height: Constants.miniPlayerArtworkImageSize)
          .padding()
        } else {
          ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
        }
        VStack (alignment: .leading) {
          Text(currentSong.title)
          Text(currentSong.artistName)
            .foregroundColor(.secondary)
        }
        Spacer()
        PlayPauseButton()
          .font(.title2)
        NextSongButton()
          .font(.title2)
          .padding()
      }
      .tint(.secondary)
      .background(Color.black.opacity(0.8))
    } else {
      ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
      
    }
  }
}
