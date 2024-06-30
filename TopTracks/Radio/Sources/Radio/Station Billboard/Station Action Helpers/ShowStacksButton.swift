import SwiftUI
import Model
import ApplicationState

struct ShowStacksButton: View {
  let station: TopTracksStation
}

extension ShowStacksButton {
  var body: some View {
    Button {
      CurrentActivity.shared.beginStationSongList(for: station)
    } label: {
      Image(systemName: "music.note.list")
    }
    .tint(.orange)  }
}
