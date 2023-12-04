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
      do {
        try rotator.rotate()
      } catch {
        fatalError(TTImplementationError.notImplementedYet.localizedDescription)
      }
    } label: {
      Image(systemName: "arrow.triangle.2.circlepath.circle")
    }
    .tint(.cyan)
  }
}
