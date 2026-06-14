import SwiftUI
import Constants
import ApplicationState
import MusicKit

public struct FullPlayerView: View {
  var currentSong = CurrentSong.shared.nowPlaying?.song
  public init() {}
}


extension FullPlayerView  {
  @ViewBuilder
  public var body: some View {
    if let currentSong {
      NavigationStack {
        VStack {
          AlbumArt(artwork: CurrentSong.shared.artwork )
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
#if !os(macOS)
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
#endif
      }
    }
    else {
      ArtworkFiller(size: Constants.miniPlayerArtworkImageSize)
    }
  }
}
