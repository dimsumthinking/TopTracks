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
      NavigationStack {
        VStack {
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
        .navigationTitle(applicationState.currentStation?.stationName ?? "Now Playing")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            SongRatingView()

          }
        
//            Button {
//
//            } label: {
//              Image(systemName: applicationState.currentSong?.anyMatchingTopTracksSong?.songRating.icon ?? "heart")
//            }
//          }
        }
        
        .gesture(DragGesture().onChanged { drag in
          if drag.location.y - drag.startLocation.y > Constants.fullPlayerSwipe {
            isShowingFullPlayer = false
          }
        }
        )
      }
      
    }
    
    else {
      ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
    }
    
  }
}
