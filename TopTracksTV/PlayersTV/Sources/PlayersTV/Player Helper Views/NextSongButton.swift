import SwiftUI
import MusicKit

struct NextSongButton: View {
}


extension NextSongButton {
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
