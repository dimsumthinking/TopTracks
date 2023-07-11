import SwiftUI
import Constants
import ApplicationState
import MusicKit

struct FullPlayerView {
  @Binding var isShowingFullPlayer: Bool
//  @EnvironmentObject private var applicationState: ApplicationState
  let currentSong: Song?
}


extension FullPlayerView: View {
  var body: some View {
    if let currentSong { //} = CurrentSong.shared.song {
      NavigationStack {
        VStack {
          AlbumArt(artwork: CurrentSong.shared.artwork )
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
        }
        .navigationTitle(CurrentStation.shared.nowPlaying?.stationName ?? "Now Playing")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          if CurrentStation.shared.canShowRating {
            ToolbarItem(placement: .navigationBarTrailing) {
              SongRatingView()
              
            }
          }
          ToolbarItem(placement: .navigationBarLeading) {
            SleepTimerView()
          }
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
