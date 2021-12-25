import MusicKit
import SwiftUI

protocol AppleMusicArtworkDisplayable {
  var artwork: Artwork? {get}
}

extension AppleMusicArtworkDisplayable {
  var backgroundColor: Color {
    color(from: artwork?.backgroundColor,
          or: .systemBackground)
          .opacity(0.8)
  }
  
  var playlistImage: ArtworkImage {
    guard let artwork = artwork else {fatalError("Artwork is missing.")}
    return ArtworkImage(artwork,
                        width: playlistArtworkImageSize,
                        height: playlistArtworkImageSize)
                        
  }
  
  var playerImage: ArtworkImage {
    guard let artwork = artwork else {fatalError("Artwork is missing.")}
    return ArtworkImage(artwork,
                        width: playerArtworkImageSize,
                        height: playerArtworkImageSize)
                        
  }
  
  var primaryColor: Color {
    color(from: artwork?.primaryTextColor,
          or: .primary)
  }
  
  var secondaryColor: Color {
    color(from: artwork?.secondaryTextColor,
          or: .secondary).opacity(0.8)
  }
}
