import SwiftUI
import MusicKit

struct NewStationSongArtworkView {
  let artwork: Artwork
  
  init?(for artwork: Artwork?) {
    guard let artwork = artwork else {return nil}
    self.artwork = artwork
  }
}

extension NewStationSongArtworkView: View {
  var body: some View {
      ArtworkImage(artwork,
                   width: songPreviewArtworkImageSize,
                   height: songPreviewArtworkImageSize)
        .border(Color.primary.opacity(0.3))
        .padding()
  }
}
