import SwiftUI
import MusicKit
import Constants

struct AlbumArt {
  let currentSong: Song
}

extension AlbumArt: View {
  var body: some View {
    if let artwork = currentSong.storedArtwork {
      ArtworkImage(artwork,
                   width: Constants.fullPlayerArtworkImageSize,
                   height: Constants.fullPlayerArtworkImageSize)
      .padding()
    } else {
      ArtworkFiller(size: Constants.fullPlayerArtworkImageSize)
    }
  }
}
