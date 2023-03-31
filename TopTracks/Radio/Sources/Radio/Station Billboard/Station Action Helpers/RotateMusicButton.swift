import SwiftUI
import Model
import StationUpdaters

struct RotateMusicButton {
  let station: TopTracksStation
}

extension RotateMusicButton: View {
  var body: some View {
    Button {
      let rotator = RotateExistingMusic(in: station)
      rotator.rotate()
    } label: {
      Image(systemName: "arrow.triangle.2.circlepath.circle")
    }
    .tint(.cyan)
  }
}
