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
      do {try adder.add()}
      catch { fatalError(TTImplementationError.notImplementedYet.localizedDescription)}
    } label: {
      Image(systemName: "goforward.plus")
    }
    .tint(.mint)
  }
}
