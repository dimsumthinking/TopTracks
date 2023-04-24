import SwiftUI
import Constants
import ApplicationState
import MusicKit

struct PlayPauseButton {
  @ObservedObject var state =  ApplicationMusicPlayer.shared.state
}


extension PlayPauseButton: View {
  var body: some View {
    Group {
      switch state.playbackStatus {
      case .paused:
        Button {
          Task {
            try await ApplicationMusicPlayer.shared.play()
          }
        } label: {
          Image(systemName: "play.fill")
        }
      case .playing:
        Button {
          Task {
            ApplicationMusicPlayer.shared.pause()
          }
        } label: {
          Image(systemName: "pause.fill")
        }
      default:
        Button {
        } label: {
          Image(systemName: "play.slash")
        }
      }
    }
  }
}
