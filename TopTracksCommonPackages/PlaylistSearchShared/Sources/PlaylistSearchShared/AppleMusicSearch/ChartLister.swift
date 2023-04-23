import MusicKit
import Combine

@MainActor
public class ChartLister: ObservableObject {
  @Published public private(set) var playlists =  MusicItemCollection<Playlist>()
  public let kind: MusicCatalogChartKind
  public init(kind: MusicCatalogChartKind) {
    self.kind = kind
    Task {
      try await chartSearch(kind: kind)
    }
  }
}

extension ChartLister {
  private func chartSearch(kind: MusicCatalogChartKind) async throws {
    let request = MusicCatalogChartsRequest(kinds: [kind],
                                            types: [Playlist.self])
    let response = try await request.response()
    if let listOfTopPlaylists = response.playlistCharts.filter({$0.kind == kind}).first?.items {
      playlists = listOfTopPlaylists
      Task.detached {
        try await self.downloadMorePlaylists(needsSorting: kind == .mostPlayed)
      }
    }
  }


  private func downloadMorePlaylists(needsSorting: Bool) async throws {
    while playlists.hasNextBatch && playlists.count < 200 {
      let addedPlaylists = (try? await playlists.nextBatch()) ?? MusicItemCollection<Playlist>()
      await MainActor.run {
        self.playlists += addedPlaylists
      }
    }
  }
}
