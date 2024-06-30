import SwiftUI
import MusicKit
import ApplicationState

struct StationPlayButton: View {
  
}

extension StationPlayButton {
  var body: some View {
    Button {
      Task {
        do {
          try await ApplicationMusicPlayer.shared.play()
        } catch {
          CurrentStation.shared.noStationSelected()
        }
      }
    } label: {
      Image(systemName: "play.fill")
    }
    .buttonStyle(.card)
    .font(.headline)
  }
}
