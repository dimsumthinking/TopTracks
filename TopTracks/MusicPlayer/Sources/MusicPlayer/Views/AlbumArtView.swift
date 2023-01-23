import SwiftUI
import MusicKit

public struct AlbumArtView {
  let artwork: Artwork?
  public init(_ artwork: Artwork?) {
    self.artwork = artwork
  }
}

extension AlbumArtView: View {
  public var body: some View {
    if let artwork {
      AsyncImage(url: artwork.url(width: 300, height: 300)) { image in
        image
          .resizable()
          .scaledToFit()
          .scaleEffect(0.75)
      } placeholder: {
        ZStack {
          Rectangle()
            .scaledToFit()
            .scaleEffect(0.75)
            .foregroundColor(.secondary.opacity(0.3))
          Image(systemName: "music.note")
            .font(.largeTitle)
        }
      }
    } else {
      Rectangle()
        .scaledToFit()
        .scaleEffect(0.75)
        .foregroundColor(.clear)
    }
    
  }
}
