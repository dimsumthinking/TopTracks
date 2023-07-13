import SwiftUI
import Constants
import ApplicationState
import MusicKit

struct MiniPlayerView {
  @Binding var isShowingFullPlayer: Bool
  var currentSong = CurrentSong.shared.song
}


extension MiniPlayerView: View {
  var body: some View {
    if let currentSong {
      HStack(spacing: 4) {
        if let artwork = CurrentSong.shared.artwork {
          ArtworkImage(artwork,
                       width: 2 * Constants.miniPlayerArtworkImageSize/3,
                       height: 2 * Constants.miniPlayerArtworkImageSize/3)
          .padding()
          .onTapGesture {
            isShowingFullPlayer = true
          }
        } else {
          ArtworkFiller(size: 0.66 * Constants.miniPlayerArtworkImageSize )
        }
        VStack (alignment: .leading) {
          Text(currentSong.title)
            .lineLimit(2)
          Text(currentSong.artistName)
            .lineLimit(2)
            .foregroundColor(.secondary)
        }
        .onTapGesture {
          isShowingFullPlayer = true
        }
        Spacer()
        PlayPauseButton()
          .font(.title)
        NextSongButton()
          .font(.headline)
          .padding()
      }
      .tint(.secondary)
      .background(.regularMaterial)
      .shadow( radius: 20, x: 0, y: -10)
      .gesture(DragGesture().onChanged { drag in
        if  drag.startLocation.y - drag.location.y > Constants.fullPlayerSwipe {
          isShowingFullPlayer = true
        }
      }
      )
    } else {
      ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
    }
  }
}
