import SwiftUI
import MusicKit

struct AppleMusicStationArtworkView {
  let artwork: Artwork?
}

extension AppleMusicStationArtworkView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.secondary.opacity(0.2))
        .frame(width: miniArtworkImageSize,
               height: miniArtworkImageSize,
               alignment: .center)
        .padding()
      if let artwork = artwork {
        ArtworkImage(artwork,
                     width: miniArtworkImageSize,
                     height: miniArtworkImageSize)
        .padding()
      }
    }
  }
}
