import SwiftUI
import MusicKit

struct AppleMusicPlaylistsInCategoryChooserView {
  @StateObject private var playlistsInCategory: AppleMusicPlaylistsInCategory
  private var name: String
  @State private var filterString = ""
}

extension AppleMusicPlaylistsInCategoryChooserView {
  init(for category: AppleMusicCategory) {
    self.init(playlistsInCategory: AppleMusicPlaylistsInCategory(category),
              name: category.description)
  }
}

extension AppleMusicPlaylistsInCategoryChooserView: View {
  var body: some View {
    List(filteredPlaylists) {playlist in
      NavigationLink {
        MusicTestView(for: playlist)
      } label: {
        AppleMusicPlaylistBillboardView(for: playlist)
      }
    }
    .searchable(text: $filterString)
    .modifier(NewStationCancellation())
    .navigationTitle(name)
  }
}

extension AppleMusicPlaylistsInCategoryChooserView {
  private var filteredPlaylists: [Playlist] {
    guard !filterString.isEmpty else {return playlistsInCategory.playlists}
    return playlistsInCategory.playlists.filter {playlist in
      return playlist.name.lowercased().contains(filterString.lowercased()) ||
      (playlist.featuredArtists?.filter{$0.name.lowercased().contains(filterString.lowercased())}.count ?? 0) > 0
    }
  }
}


