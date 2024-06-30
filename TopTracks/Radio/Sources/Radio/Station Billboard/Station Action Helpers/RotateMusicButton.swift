import SwiftUI
import Model

struct RotateMusicButton: View {
  let station: TopTracksStation
}

extension RotateMusicButton {
  var body: some View {
    Button {
      do {
        try station.rotate()
      } catch {
        RadioLogger.stationMusicRotator.info("Couldn't rotate the music for \(station.stationName)")
      }
    } label: {
      Image(systemName: "arrow.triangle.2.circlepath.circle")
    }
    .tint(.cyan)
  }
}
