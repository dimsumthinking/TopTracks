import SwiftUI
import MusicKit

struct AppleMusicPlaylistsInCategoryView {
  @StateObject private var playlistsInCategory: AppleMusicPlaylistsInCategory
}

extension AppleMusicPlaylistsInCategoryView {
  init(for category: AppleMusicCategory) {
    self.init(playlistsInCategory: AppleMusicPlaylistsInCategory(category))
  }
}

extension AppleMusicPlaylistsInCategoryView: View {
  var body: some View {
    List(playlistsWithArtwork) {playlist in
      NavigationLink {
        AppleMusicPlaylistTracksView(playlist: playlist)
          .navigationTitle(Text(playlist.name))
          .navigationBarTitleDisplayMode(.inline)
      } label: {
        AppleMusicPlaylistBillboardView(playlist: playlist)
      }
    }
    .modifier(InfoModifier(message: "To create a station,\nnext Choose a Playlist"))
  }
}

extension AppleMusicPlaylistsInCategoryView {
  private var playlistsWithArtwork: [Playlist] {
    playlistsInCategory
      .playlists
      .filter {playlist in playlist.artwork != nil}
  }
}

struct AppleMusicPlaylistsInCategoryView_Previews: PreviewProvider {
  static var previews: some View {
    AppleMusicPlaylistsInCategoryView(for: .spatialAudio)
  }
}
