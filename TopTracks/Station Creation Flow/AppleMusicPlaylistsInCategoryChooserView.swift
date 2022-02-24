import SwiftUI
import MusicKit

struct AppleMusicPlaylistsInCategoryChooserView {
  @StateObject private var playlistsInCategory: AppleMusicPlaylistsInCategory
  private var name: String
}

extension AppleMusicPlaylistsInCategoryChooserView {
  init(for category: AppleMusicCategory) {
    self.init(playlistsInCategory: AppleMusicPlaylistsInCategory(category),
              name: category.description)
  }
}

extension AppleMusicPlaylistsInCategoryChooserView: View {
  var body: some View {
    List(playlistsInCategory.playlists) {playlist in
      NavigationLink {
        MusicTestView(for: playlist)
      } label: {
        AppleMusicPlaylistBillboardView(for: playlist)
      }
    }
    .modifier(StationBuildCancellation())
    .navigationTitle(name)
  }
}

