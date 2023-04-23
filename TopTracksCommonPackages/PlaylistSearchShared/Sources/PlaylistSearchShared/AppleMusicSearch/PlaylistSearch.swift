import MusicKit
import Combine

@MainActor
public class PlaylistSearch: ObservableObject {
  @Published public private(set) var playlists =  MusicItemCollection<Playlist>()
  public init(term: String) {
    Task {
      try await playlistSearch(term: term)
    }
  }
}

extension PlaylistSearch {
  nonisolated
  private func playlistSearch(term: String) async throws {
try await playlistSearchSuggestions(term: term)
    let request = MusicCatalogSearchRequest(term: term,
                                            types: [Playlist.self])
    let listOfPlaylists = try await request.response().playlists
    await MainActor.run {
      self.playlists = listOfPlaylists
    }
    try await self.downloadMorePlaylists()
  }
}

extension PlaylistSearch {
  nonisolated
  private func playlistSearchSuggestions(term: String) async throws {
    print("Getting suggestions ===================")
    let request = MusicCatalogSearchSuggestionsRequest(term: term, includingTopResultsOfTypes: [Playlist.self])
    let suggestions = try await request.response().suggestions
    print("Getting suggestions ===================", suggestions.count)
    print(suggestions.map(\.displayTerm))
  }
}

extension PlaylistSearch {
private func downloadMorePlaylists() async throws {
  while playlists.hasNextBatch && playlists.count < 200 {
    let addedPlaylists = (try? await playlists.nextBatch()) ?? MusicItemCollection<Playlist>()
    await MainActor.run {
      self.playlists += addedPlaylists
    }
  }
}
}

