import SwiftUI
import MusicKit

struct AppleMusicStationDetailView {
  let station: Station
}

extension AppleMusicStationDetailView: View {
  var body: some View {
    HStack  {
      AppleMusicStationArtworkView(artwork: station.artwork)
      VStack (alignment: .leading) {
        Text(station.name)
          .multilineTextAlignment(.leading)
          .font(.headline)
        Text(station.editorialNotes?.standard ?? "")
          .multilineTextAlignment(.leading)
          .font(.caption)
      }
      Spacer()
    }
  }
}
