import SwiftUI
import Constants
import ApplicationState
import MusicKit

struct FullPlayerView {
  @Binding var isShowingFullPlayer: Bool
  @EnvironmentObject private var applicationState: ApplicationState
}


extension FullPlayerView: View {
  var body: some View {
    if let currentSong = applicationState.currentSong {
      
      VStack {
        if let station = applicationState.currentStation {
          Text(station.name)
            .font(.headline)
            .padding()
        }
        
        AlbumArt(currentSong: currentSong)

        SongTextInfo(currentSong: currentSong)

        Spacer()
        SongScrubberView(currentSong: currentSong)
        Spacer()
        ControlPanel()
        Spacer()
        SystemVolumeSlider()
          .padding()
          .padding(.horizontal)
      }
      .onTapGesture {
        isShowingFullPlayer = false
      }
      .gesture(DragGesture().onChanged { drag in
        if drag.location.y - drag.startLocation.y > Constants.fullPlayerSwipe {
          isShowingFullPlayer = false
        } 
      }
      )
    }

    else {
      ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
    }
    
  }
}
