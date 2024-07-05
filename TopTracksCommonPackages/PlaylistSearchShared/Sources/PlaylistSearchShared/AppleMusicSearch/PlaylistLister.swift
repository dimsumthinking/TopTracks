import MusicKit
import Observation

@MainActor
@Observable
public class PlaylistLister {
  public private(set) var playlists =  MusicItemCollection<Playlist>()
  public init(category: AppleMusicCategory) {
    Task {
      try await playlistSearch(category: category)
    }
  }
}

extension PlaylistLister {
  nonisolated
  private func playlistSearch(category: AppleMusicCategory) async throws {
    let request = MusicCatalogSearchRequest(term: category.description,
                                            types: [Playlist.self])
    let listOfPlaylists = try await request.response().playlists
    await MainActor.run {
      self.playlists = listOfPlaylists
    }
    try await self.downloadMorePlaylists()
  }
}

extension PlaylistLister {
  private func downloadMorePlaylists() async throws {
    while playlists.hasNextBatch && playlists.count < 200 {
      let addedPlaylists = (try? await playlists.nextBatch()) ?? MusicItemCollection<Playlist>()
      await MainActor.run {
        self.playlists += addedPlaylists
      }
    }
  }
}

