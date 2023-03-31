import SwiftUI
import Model
import StationUpdaters

struct AddAndRotateMusicButton {
  let station: TopTracksStation
}

extension AddAndRotateMusicButton: View {
  var body: some View {
    Button {
      let adder = AddAndRotateMusic(in: station)
      adder.add()
    } label: {
      Image(systemName: "goforward.plus")
    }
    .tint(.mint)
  }
}
