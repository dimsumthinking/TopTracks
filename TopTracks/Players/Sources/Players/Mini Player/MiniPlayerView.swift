import SwiftUI
import Constants
import ApplicationState
import MusicKit

struct MiniPlayerView: View {
  @Binding var isShowingFullPlayer: Bool
  var currentSong = CurrentSong.shared.nowPlaying?.song
}


extension MiniPlayerView  {
  @ViewBuilder
  var body: some View {
      if let currentSong {
        ZStack {
          VStack {
            Spacer()
            
            Rectangle()
              .frame(height: Constants.miniPlayerArtworkImageSize * 3/2)
              .glassEffect(.regular, in: .rect)
          }
          .ignoresSafeArea()
          VStack {
            Spacer()
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
              PreviousSongButton()
              //            .font(.headline)
                .padding()
              PlayPauseButton()
              //            .font(.body)
              NextSongButton()
              //            .font(.body)
                .padding()
                .padding(.trailing)
            }
            .background(in: .capsule)
            .padding()
            //        .scrollEdgeEffectStyle(.soft, for: .bottom)
            //        .padding(.vertical, 20)
            //        .glassEffect(.regular, in: .rect)
          }
          .ignoresSafeArea()


        
      }
        
      } else {
        ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
      }

    
  }
}
