import SwiftUI
import MusicKit

struct NextSongButton {
}


extension NextSongButton: View {
  var body: some View {
    Button {
      Task {
        try await ApplicationMusicPlayer.shared.skipToNextEntry()
      }
    } label: {
      Image(systemName: "forward.fill")
    }
    
  }
}
