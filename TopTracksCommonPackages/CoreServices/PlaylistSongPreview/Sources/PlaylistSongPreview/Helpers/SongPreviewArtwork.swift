import SwiftUI
import Constants
import MusicKit

struct SongPreviewArtwork: View {
  let artwork: Artwork?
}

extension SongPreviewArtwork {
  @ViewBuilder
  var body: some View {
    if let artwork = artwork {
      ArtworkImage(artwork,
                   width: Constants.songListImageSize,
                   height: Constants.songListImageSize)
    } else {
      Image(systemName: "music.note")
        .background(Color.secondary)
        .frame(width: Constants.songListImageSize,
               height: Constants.songListImageSize)
    }
  }
}
