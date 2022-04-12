import SwiftUI
import MusicKit

struct AppleMusicStationDetailView {
  let station: Station
}

extension AppleMusicStationDetailView: View {
  var body: some View {
    HStack  {
      if let artwork = station.artwork {
        ArtworkImage(artwork,
                     width: miniArtworkImageSize,
                     height: miniArtworkImageSize)
        
      }
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
