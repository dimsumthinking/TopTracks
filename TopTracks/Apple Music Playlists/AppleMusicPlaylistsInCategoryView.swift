import SwiftUI
import MusicKit

struct AppleMusicPlaylistsInCategoryView {
  @StateObject private var playlistsInCategory: AppleMusicPlaylistsInCategory
  private var name: String
}

extension AppleMusicPlaylistsInCategoryView {
  init(for category: AppleMusicCategory) {
    self.init(playlistsInCategory: AppleMusicPlaylistsInCategory(category),
              name: category.description)
  }
}

extension AppleMusicPlaylistsInCategoryView: View {
  var body: some View {
    List(playlistsInCategory.playlists) {playlist in
      NavigationLink {
        NewStationTrackSelectionView(for: playlist)
      } label: {
        AppleMusicPlaylistBillboardView(for: playlist)
      }
    }
    .modifier(StationBuildCancellation())
    .navigationTitle(name + " Playlists")
  }
}
