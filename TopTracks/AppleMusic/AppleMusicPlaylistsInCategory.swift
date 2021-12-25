import MusicKit
import Foundation

class AppleMusicPlaylistsInCategory: ObservableObject {
  @Published var playlists: MusicItemCollection<Playlist> = []
  
  init(_ category: AppleMusicCategory) {
    Task.detached {
      await  self.startSearch(for: category)
    }
  }
}

extension AppleMusicPlaylistsInCategory {
  @MainActor
  private func startSearch(for category: AppleMusicCategory)  async {
    var request = MusicCatalogSearchRequest(term: category.description,
                                            types: [Playlist.self])
    request.limit = 25
    let response = try? await request.response()
    guard let playlists = response?.playlists else {return}
    self.playlists = playlists
  }
}

