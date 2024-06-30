import SwiftUI
import ApplicationState
import AudioToolbox
import MusicKit
import Constants
import Model

public struct MainPlayerView: View {
  @State private var isShowingFullPlayer = false
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  public init() {}
}

extension MainPlayerView {
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
    .onChange(of: queue.currentEntry) { oldEntry, newEntry in
      if let newEntry {
        do {
          try CurrentSong.shared.setCurrentSong(using: newEntry)
        } catch {
          PlayersLogger.updatingSong.info("Unable to set current song to \(newEntry)")
        }
      }
    }
  }
}
