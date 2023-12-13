import SwiftUI
import Model

struct RotateMusicButton {
  let station: TopTracksStation
}

extension RotateMusicButton: View {
  var body: some View {
    Button {
      do {
        try station.rotate()
      } catch {
        RadioTVLogger.stationMusicRotator.info("Couldn't rotate the music for \(station.stationName)")
      }
    } label: {
      VerticalSpacedImage(systemName: "arrow.triangle.2.circlepath.circle")
    }
    .buttonStyle(.card)
  }
}
