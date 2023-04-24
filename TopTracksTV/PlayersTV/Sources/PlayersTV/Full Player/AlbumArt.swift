import SwiftUI
import MusicKit
import Constants

struct AlbumArt {
  let artwork: Artwork?
}

extension AlbumArt: View {
  var body: some View {
    if let artwork {
      ArtworkImage(artwork,
                   width: Constants.fullPlayerArtworkImageSize,
                   height: Constants.fullPlayerArtworkImageSize)
      .padding()
    } else {
      ArtworkFiller(size: Constants.fullPlayerArtworkImageSize)
    }
  }
}
