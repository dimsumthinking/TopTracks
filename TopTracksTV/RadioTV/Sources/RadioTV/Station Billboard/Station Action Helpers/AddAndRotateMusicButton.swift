import SwiftUI
import Model

struct AddAndRotateMusicButton: View {
  let station: TopTracksStation
}

extension AddAndRotateMusicButton {
  var body: some View {
    Button {
      do {
        try station.addAndRotate()
      }
      catch { RadioTVLogger.stationMusicRotator.info("Couldn't add rotate the music for \(station.stationName)")
      }
    } label: {
      Image(systemName: "goforward.plus")
    }
    .tint(.mint)
  }
}
