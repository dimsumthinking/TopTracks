import SwiftUI
import MusicKit

struct AppleMusicPlaylistBillboardView {
  @State private(set) var playlist: AppleMusicPlaylistBillboard
}

extension AppleMusicPlaylistBillboardView: View {
  var body: some View {
    return HStack(alignment: .top) {
      AppleMusicPlaylistArtworkView(for: playlist.artwork)
      AppleMusicPlaylistFeaturedArtistView(playlist: playlist)
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(playlist.backgroundColor.opacity(0.7))
    .foregroundColor(playlist.textColor)

  }
}

