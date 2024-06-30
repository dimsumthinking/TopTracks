import SwiftUI
import PlaylistSearchTV
import ApplicationState
import RadioTV
import PlayersTV
import PlaylistSongPreview
import MusicKit

struct MainView: View {
  @State private var currentActivity = CurrentActivity.shared
  @State private var isShowingFullPlayer = false
}

extension MainView {
  var body: some View {
    Group {
      switch currentActivity.appActivity {
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



//struct MainView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView()
//  }
//}



//import SwiftUI
//import PlaylistSearchTV
//import ApplicationState
//import RadioTV
//import PlayersTV
//import PlaylistSongPreview
//import MusicKit
//
//struct MainView {
//  @State private var currentActivity = TopTracksAppActivity.enjoying
//  @State private var isShowingFullPlayer = false
//}
//
//extension MainView: View {
//  var body: some View {
//    Group {
//      switch currentActivity {
//      case .enjoying, .importing:
//        ZStack {
//          MainStationsView(isShowingFullPlayer: $isShowingFullPlayer)
//          MainPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
//        }
//      case .creating:  MainCreationView()
//      case .viewingOrEditing(let station): MainStationSongListView(station)
//      }
//    }
//    .onPlayPauseCommand {
//      playPause()
//    }
//    
//    
//    .task {
//      await registerForCurrentActivity()
//    }
//    
//  }
//}
//
//extension MainView {
//  private func playPause() {
////    #if !os(macOS)
//    if songPreviewPlayer.isNotPreviewing {
//      switch ApplicationMusicPlayer.shared.state.playbackStatus {
//      case .playing:
//        ApplicationMusicPlayer.shared.pause()
//      case .paused:
//        Task {
//          try await ApplicationMusicPlayer.shared.play()
//        }
//      default:
//        return
//      }
//    
//    }
////    #endif
//  }
//}
//
//extension MainView {
//  private func registerForCurrentActivity() async {
//    for await activity in CurrentActivity.shared.activities {
//      currentActivity = activity
//    }
//  }
//}
//
//
////struct MainView_Previews: PreviewProvider {
////  static var previews: some View {
////    MainView()
////  }
////}
