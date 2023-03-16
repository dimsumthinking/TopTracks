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
          .onTapGesture {
            isShowingFullPlayer = false
          }
        
        SongTextInfo(currentSong: currentSong)
        
        
        Spacer()
        
        SongScrubberView(currentSong: currentSong)
          .padding()
          .font(.headline)
          .tint(.primary)
        Spacer()
        ControlPanel()
        Spacer()
        HStack {
          Spacer()
          SleepTimer()
          Spacer()
          RoutePicker()
            .frame(width: 20, height: 20)
          Spacer()
        }
        .padding(.bottom)
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
