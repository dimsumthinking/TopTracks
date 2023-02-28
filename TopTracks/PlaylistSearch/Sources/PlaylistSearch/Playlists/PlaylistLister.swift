import MusicKit
import Combine

@MainActor
class PlaylistLister: ObservableObject {
  @Published var playlists =  MusicItemCollection<Playlist>()
  init(category: AppleMusicCategory) {
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



//import MusicKit
//import Combine
//
//@MainActor
//class PlaylistLister: ObservableObject {
//  @Published var playlists =  MusicItemCollection<Playlist>()
//  init() { //(kind: MusicCatalogChartKind) {
//    Task {
//      try await chartSearch()//kind: kind)
//    }
//  }
//}
//
//extension PlaylistLister {
//  private func chartSearch() async throws {
////    let request = MusicCatalogSearchRequest(term:, types: [Playlist]) (kinds: [kind],
////                                            types: [Playlist.self])
////    let response = try await request.response()
////    if let listOfTopPlaylists = response.playlistCharts.filter({$0.kind == kind}).first?.items {
////      playlists = listOfTopPlaylists
////      Task.detached {
////        try await self.downloadMorePlaylists(needsSorting: kind == .mostPlayed)
////      }
////    }
//  }
//
//
//  private func downloadMorePlaylists(needsSorting: Bool) async throws {
//    while playlists.hasNextBatch && playlists.count < 200 {
//      let addedPlaylists = (try? await playlists.nextBatch()) ?? MusicItemCollection<Playlist>()
//      await MainActor.run {
//        self.playlists += addedPlaylists
//      }
//    }
//  }
//}
