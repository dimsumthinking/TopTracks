import SwiftUI
import MusicKit

struct AppleMusicPlaylistArtworkView {
  let artwork: Artwork
  
  init?(for artwork: Artwork?) {
    guard let artwork = artwork else {return nil}
    self.artwork = artwork
  }
}

extension AppleMusicPlaylistArtworkView: View {
  var body: some View {
    ArtworkImage(artwork,
                 width: playlistArtworkImageSize)
      .padding()
  }
}
