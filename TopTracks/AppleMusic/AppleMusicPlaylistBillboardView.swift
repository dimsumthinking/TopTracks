import SwiftUI
import MusicKit

struct AppleMusicPlaylistBillboardView {
  let playlist: Playlist
}


extension AppleMusicPlaylistBillboardView: View {
  var body: some View {
    HStack(alignment: .top) {
      VStack {
        playlist.playlistImage
          .border(playlist.primaryColor.opacity(0.3))
          .padding()
      }
      VStack(alignment: .leading) {
        Text(playlist.name)
          .foregroundColor(playlist.primaryColor)
          .padding(.top)
        Text(playlist.curatorName ?? "Unknown")
          .foregroundColor(playlist.secondaryColor)
          .padding(.top, 4)
      }
      Spacer()
    }.background(playlist.backgroundColor)

      .frame(maxWidth: .infinity)
  }
}

extension Playlist: AppleMusicArtworkDisplayable {}
