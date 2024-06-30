import SwiftUI
import ApplicationState
import AudioToolbox
import MusicKit
import Constants

public struct MainPlayerView: View {
  @Binding private var isShowingFullPlayer: Bool
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  public init(isShowingFullPlayer: Binding<Bool>) {
    self._isShowingFullPlayer = isShowingFullPlayer
  }
}

extension MainPlayerView {
  public var body: some View {
    VStack {
      if isShowingFullPlayer {
        FullPlayerView(isShowingFullPlayer: $isShowingFullPlayer)
          .transition(.scale(scale: 0.05,
                             anchor: Constants.anchorPointForPlayerTransition))
      } else {
        EmptyView()
      }
    }
    .animation(.easeInOut, value: isShowingFullPlayer)
    .onChange(of: queue.currentEntry) { oldEntry, newEntry in
      if let newEntry {
        do {
          try CurrentSong.shared.setCurrentSong(using: newEntry)
        } catch {
          PlayersTVLogger.updatingSong.info("Unable to set current song to \(newEntry)")
        }
      }
    }
  }
}




//
//
//
//extension MainPlayerView: View {
//  public var body: some View {
//    VStack {
//      HStack {
//        Button {
//          CurrentActivity.shared.endImporting()
//        } label: {
//          Text("\(Image(systemName: "arrow.left")) Stations")
//        }
//        Spacer()
//
//      }
//      Spacer()
//      if let currentSong {
//        SongTextInfo(currentSong: currentSong)
//
//      } else {
//        Text("Main Player")
//      }
//      Spacer()
//    }
//    .onChange(of: queue.currentEntry) { entry in
//      if let entry {
//        CurrentSong.shared.setCurrentSong(using: entry)
//      }
//    }
//  }
//}
