import SwiftUI
import MusicKit

struct AppleMusicPlaylistArtworkView {
  let artwork: Artwork?
  
  //  init?(for artwork: Artwork?) {
  //    guard let artwork = artwork else {return nil}
  //    self.artwork = artwork
  //  }
}

extension AppleMusicPlaylistArtworkView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.secondary.opacity(0.2))
        .frame(width: playlistArtworkImageSize,
               height: playlistArtworkImageSize,
               alignment: .center)
        .padding()
      if let artwork = artwork {
        ArtworkImage(artwork,
                     width: playlistArtworkImageSize,
                     height: playlistArtworkImageSize)
        .padding()
      }
    }
  }
}
