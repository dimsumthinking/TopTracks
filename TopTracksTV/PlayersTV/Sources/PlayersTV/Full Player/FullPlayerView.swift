import SwiftUI
import Constants
import ApplicationState
import MusicKit


struct FullPlayerView: View {
  @Binding var isShowingFullPlayer: Bool
  //  @EnvironmentObject private var applicationState: ApplicationState
  var currentSong = CurrentSong.shared.nowPlaying?.song
}


extension FullPlayerView {
  var body: some View {
    VStack {
      ZStack {
        Text(CurrentStation.shared.nowPlaying?.stationName ?? "Now Playing")
//        Text(CurrentStation.shared.topTracksStation?.stationName ?? "Now Playing")
        HStack {
          Button {
            isShowingFullPlayer = false
          } label: {
            Text("\(Image(systemName: "arrow.left")) Stations")
          }
          Spacer()
        }
      }
      if let currentSong { //} = CurrentSong.shared.song {
        
        AlbumArt(artwork: CurrentSong.shared.artwork )
        
        SongTextInfo(currentSong: currentSong)
        
        Spacer()
        ZStack {
          SongScrubberView(currentSong: currentSong)
            .padding()
            .font(.headline)
            .tint(.primary)
          //          Spacer()
          ControlPanel()
        }
        //          Spacer()
      }
      else {
        Spacer()
      }
      //        .navigationTitle(CurrentStation.shared.topTracksStation?.stationName ?? "Now Playing")
      //        .navigationBarTitleDisplayMode(.inline)
      //        .toolbar {
      //          if CurrentStation.shared.canShowRating {
      //            ToolbarItem(placement: .navigationBarTrailing) {
      //              SongRatingView()
      //
      //            }
      //          }
      //          ToolbarItem(placement: .navigationBarLeading) {
      //            SleepTimerView()
      //          }
      
      
      //        .gesture(DragGesture().onChanged { drag in
      //          if drag.location.y - drag.startLocation.y > Constants.fullPlayerSwipe {
      //            isShowingFullPlayer = false
      //          }
      //        }
      //        )
    }
    .onExitCommand {
      isShowingFullPlayer = false
    }
    
    
    
    
  }
}
