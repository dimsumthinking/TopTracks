import SwiftUI
import Model
import StationUpdaters

struct RotateMusicButton {
  let station: TopTracksStation
}

extension RotateMusicButton: View {
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
