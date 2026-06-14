import SwiftUI
import Constants
import ApplicationState
import MusicKit

public struct MiniPlayerView: View {
  var currentSong = CurrentSong.shared.nowPlaying?.song
  public init() {}
}


extension MiniPlayerView  {
  @ViewBuilder
  public var body: some View {
    if let currentSong {
      VStack {
        Spacer()
        HStack(spacing: 4) {
          if let artwork = CurrentSong.shared.artwork {
            ArtworkImage(artwork,
                         width: 2 * Constants.miniPlayerArtworkImageSize/3,
                         height: 2 * Constants.miniPlayerArtworkImageSize/3)
            .padding()
            .padding(.leading)
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
          Spacer()
          PreviousSongButton()
            .padding()
          PlayPauseButton()
          NextSongButton()
            .padding()
            .padding(.trailing)
        }
        .glassEffect(.regular, in: .rect)
        .contentShape(.rect)
      }
      .ignoresSafeArea()
      
    } else {
      ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
    }
  }
}
