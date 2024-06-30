import SwiftUI
import MusicKit

struct StationPauseButton: View {
  
}

extension StationPauseButton {
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
