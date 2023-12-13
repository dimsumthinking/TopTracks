import SwiftUI
import PlaylistSearchTV
import ApplicationState
import RadioTV
import PlayersTV
import StationUpdaters
import PlaylistSongPreview
import MusicKit

struct MainView {
  @State private var currentActivity = TopTracksAppActivity.enjoying
  @State private var isShowingFullPlayer = false
}

extension MainView: View {
  var body: some View {
    Group {
      switch currentActivity {
      case .enjoying, .importing:
        ZStack {
          MainStationsView(isShowingFullPlayer: $isShowingFullPlayer)
          MainPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
        }
      case .creating:  MainCreationView()
      case .viewingOrEditing(let station): MainStationSongListView(station)
      }
    }
    .onPlayPauseCommand {
      playPause()
    }
    
    
    .task {
      await registerForCurrentActivity()
    }
    
  }
}

extension MainView {
  private func playPause() {
//    #if !os(macOS)
    if songPreviewPlayer.isNotPreviewing {
      switch ApplicationMusicPlayer.shared.state.playbackStatus {
      case .playing:
        ApplicationMusicPlayer.shared.pause()
      case .paused:
        Task {
          try await ApplicationMusicPlayer.shared.play()
        }
      default:
        return
      }
    
    }
//    #endif
  }
}

extension MainView {
  private func registerForCurrentActivity() async {
    for await activity in CurrentActivity.shared.activities {
      currentActivity = activity
    }
  }
}


//struct MainView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView()
//  }
//}
