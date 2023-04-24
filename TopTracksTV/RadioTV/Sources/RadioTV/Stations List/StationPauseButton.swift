import SwiftUI
import MusicKit

struct StationPauseButton {
  
}

extension StationPauseButton: View {
  var body: some View {

      
      Button {
        ApplicationMusicPlayer.shared.pause()
      } label: {
        Image(systemName: "pause.fill")
      }
      .buttonStyle(.card)
      .font(.headline)

  }
}
