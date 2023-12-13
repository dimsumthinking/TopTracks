import SwiftUI
import Model

struct AddAndRotateMusicButton {
  let station: TopTracksStation
}

extension AddAndRotateMusicButton: View {
  var body: some View {
    Button {
      do {
        try station.addAndRotate()
      }
      catch { RadioLoggerTV.stationMusicRotator.info("Couldn't add rotate the music for \(station.stationName)")
      }
    } label: {
      Image(systemName: "goforward.plus")
    }
    .tint(.mint)
  }
}
