import SwiftUI
import MusicKit

struct AppleMusicPlaylistBillboardView {
  let playlist: AppleMusicPlaylistBillboard
  
  init(for playlist: Playlist) {
    self.playlist = AppleMusicPlaylistBillboard(playlist: playlist)
  }
}

extension AppleMusicPlaylistBillboardView: View {
  var body: some View {
    return HStack(alignment: .top) {
      AppleMusicPlaylistArtworkView(artwork: playlist.artwork)
      AppleMusicPlaylistFeaturedArtistView(playlist: playlist)
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(playlist.backgroundColor.opacity(0.7))
    .foregroundColor(playlist.textColor)

  }
}

