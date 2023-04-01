import SwiftUI
import ApplicationState
import AudioToolbox
import MusicKit
import Constants

public struct MainPlayerView {
  @State private var isShowingFullPlayer = false
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  public init() {
    
  }
}

extension MainPlayerView: View {
  public var body: some View {
    VStack {
      if isShowingFullPlayer {
        FullPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
          .transition(.scale(scale: 0.05,
                             anchor: Constants.anchorPointForPlayerTransition))
      } else {
        
        Spacer()
        MiniPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
      }
    }
    .animation(.easeInOut, value: isShowingFullPlayer)
    .onChange(of: queue.currentEntry) { entry in
      if let entry {
        ApplicationState.shared.setCurrentSong(using: entry)
      }
    }
  }
}
