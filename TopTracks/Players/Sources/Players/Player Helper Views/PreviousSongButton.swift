import SwiftUI
import MusicKit

struct PreviousSongButton {
}


extension PreviousSongButton: View {
  var body: some View {
    let player = ApplicationMusicPlayer.shared
    Button {
      Task {
        if player.playbackTime < 6 {
          try await player.skipToPreviousEntry()
        } else {
          player.restartCurrentEntry()
        }
      }
    } label: {
      Image(systemName: "backward.fill")
    }
    
  }
}
