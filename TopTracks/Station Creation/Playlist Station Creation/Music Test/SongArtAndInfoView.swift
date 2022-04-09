import SwiftUI
import MusicKit

struct SongArtAndInfoView {
  let song: Song
}

extension SongArtAndInfoView: View {
  var body: some View {
    VStack {
      if let artwork = song.artwork {
        ArtworkImage(artwork,
                     width: artworkPreviewImageWidth)
        .border(Color.primary.opacity(0.3))
        .padding(.horizontal)
      }
      Text(song.title).font(.title2)
      Text(song.artistName)
    }
    .multilineTextAlignment(.center)
    .foregroundColor(.secondary)
    .padding([.horizontal])
  }
}
