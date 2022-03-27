import MusicKit
import Foundation

class AppleMusicPlaylistsInCategory: ObservableObject {
  @Published var playlists: [Playlist] = []
  
  init(_ category: AppleMusicCategory) {
    Task {
      await self.startSearch(for: category)
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
    self.playlists = playlists.filter{playlist in playlist.artwork != nil}
    for index in self.playlists.indices {
      guard let playlistWithArtists = try? await self.playlists[index].with([.featuredArtists]) else {return}
      self.playlists[index] = playlistWithArtists
    }    
  }
}


// TODO: filter by featured artists as well
// TODO:  Return more than 25 items if possible
// TODO: loading featured artists twice - remove other one
