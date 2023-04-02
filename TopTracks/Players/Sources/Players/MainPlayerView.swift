import SwiftUI
import ApplicationState
import AudioToolbox
import MusicKit
import Constants

public struct MainPlayerView {
  @State private var isShowingFullPlayer = false
  @State private var currentSong: Song?
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  public init() {}
}

extension MainPlayerView: View {
  public var body: some View {
    VStack {
      if isShowingFullPlayer {
        FullPlayerView(isShowingFullPlayer: $isShowingFullPlayer,
                       currentSong: currentSong)
          .transition(.scale(scale: 0.05,
                             anchor: Constants.anchorPointForPlayerTransition))
      } else {
        
        Spacer()
        MiniPlayerView(isShowingFullPlayer: $isShowingFullPlayer,
                       currentSong: currentSong)
      }
    }
    .animation(.easeInOut, value: isShowingFullPlayer)
    .onChange(of: queue.currentEntry) { entry in
      if let entry {
        CurrentSong.shared.setCurrentSong(using: entry)
      }
    }
    .onAppear {
      currentSong = CurrentSong.shared.song
    }
    .task {
      await subscribeToCurrentSong()
    }
   
  }
}

extension MainPlayerView {
  private func subscribeToCurrentSong() async {
    do {
      let songs = try CurrentSong.shared.currentSongStream()
      for await song in songs {
        self.currentSong = song
      }
    } catch {
      print(error)
    }
  }
}
