import SwiftUI
import MusicKit

struct SongArtAndInfoView {
  let song: Song
  @State private var movingOn: Bool = false
}

extension SongArtAndInfoView: View {
  var body: some View {
    VStack {
      if let artwork = song.artwork {
        if movingOn {
          Rectangle()
            .frame(width: artworkPreviewImageWidth, height: artworkPreviewImageWidth, alignment: .center)
            .foregroundColor(.red)
        } else {
          ArtworkImage(artwork,
                       width: artworkPreviewImageWidth) //UIScreen.main.bounds.width * 1 / 2,
          //                     height: UIScreen.main.bounds.width * 1 / 2)
          .border(Color.primary.opacity(0.3))
          .padding(.horizontal)
        }
      }
      Text(song.title).font(.title2)
      Text(song.artistName)
    }
    .multilineTextAlignment(.center)
    .foregroundColor(.secondary)
    .padding([.horizontal])
    .onDisappear{movingOn = true}
  }
}
