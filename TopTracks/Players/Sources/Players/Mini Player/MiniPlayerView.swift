import SwiftUI
import Constants
import ApplicationState
import MusicKit

struct MiniPlayerView {
  @Binding var isShowingFullPlayer: Bool
  let currentSong: Song?
}


extension MiniPlayerView: View {
  var body: some View {
    if let currentSong {
      HStack(spacing: 4) {
        if let artwork = CurrentSong.shared.artwork {
          ArtworkImage(artwork,
                       width: Constants.miniPlayerArtworkImageSize,
                       height: Constants.miniPlayerArtworkImageSize)
          .padding()
          .onTapGesture {
            isShowingFullPlayer = true
          }
        } else {
          ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
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
      .background(.thinMaterial)
      .shadow( radius: 20, x: 0, y: -2)
//      .onTapGesture {
//        isShowingFullPlayer = true
//      }
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
