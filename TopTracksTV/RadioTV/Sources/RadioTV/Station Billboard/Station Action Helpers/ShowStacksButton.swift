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
//      ApplicationState.shared.beginStationgSongList(for: station)
    } label: {
      VerticalSpacedImage(systemName: "music.note.list")
    }
    .buttonStyle(.card)
  }
}
