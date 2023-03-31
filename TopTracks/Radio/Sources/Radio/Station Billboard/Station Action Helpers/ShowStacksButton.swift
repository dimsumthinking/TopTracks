import SwiftUI
import Model
import ApplicationState

struct ShowStacksButton {
  let station: TopTracksStation
}

extension ShowStacksButton: View {
  var body: some View {
    Button {
      ApplicationState.shared.beginStationgSongList(for: station)
    } label: {
      Image(systemName: "music.note.list")
    }
    .tint(.orange)  }
}
