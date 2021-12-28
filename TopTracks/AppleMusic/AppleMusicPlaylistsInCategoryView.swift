import SwiftUI
import MusicKit

struct AppleMusicPlaylistsInCategoryView {
  @StateObject private var playlistsInCategory: AppleMusicPlaylistsInCategory
  private var name = ""
}

extension AppleMusicPlaylistsInCategoryView {
  init(for category: AppleMusicCategory) {
    self.init(playlistsInCategory: AppleMusicPlaylistsInCategory(category))
    self.name = category.description
  }
}

extension AppleMusicPlaylistsInCategoryView: View {
  var body: some View {
    VStack {
      InstructionView("Choose a Playlist.")
      List(playlistsWithArtwork) {playlist in
        NavigationLink {
          StationCreationView(playlist: playlist)
        } label: {
          AppleMusicPlaylistBillboardView(playlist: playlist)
        }
      }
    }
    .modifier(StationBuildCancellation())
    .navigationTitle(name)
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
