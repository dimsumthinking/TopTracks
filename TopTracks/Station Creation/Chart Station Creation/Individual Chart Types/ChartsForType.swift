import Foundation
import MusicKit

class ChartsForType: ObservableObject {
  @Published private(set) var playlists: [Playlist] = []
  
  func search(for chartType: TopTracksChartType) {
    switch chartType {
    case .cityCharts:
      Task {await citySearch()}
    case .dailyTop100:
      Task {await countrySearch()}
    case .playlists:
      Task {await topChartsSearch()}
    default:
      return
    }
  }
}

@MainActor
extension ChartsForType {
  private func citySearch()  async {
    let request = MusicCatalogSearchRequest(term: "Top 25:",
                                            types: [Playlist.self])
    let response = try? await request.response()
    guard let playlists = response?.playlists else {return}
    Task { await continueDownloading(playlists)}
  }
  
  private func countrySearch()  async {
    let request = MusicCatalogSearchRequest(term: "Top 100:",
                                            types: [Playlist.self])
    let response = try? await request.response()
    guard let playlists = response?.playlists else {return}
    Task { await continueDownloading(playlists)}
  }
  
  private func continueDownloading(_ playlists: MusicItemCollection<Playlist>) async {
    var playlists = playlists
    while playlists.hasNextBatch {
      self.playlists.append(contentsOf: playlists)
      self.playlists = Set(self.playlists).filter{playlist in playlist.isChart ?? false}
        .filter{playlist in playlist.curatorName == "Apple Music"}
        .sorted{$0.name < $1.name}
      playlists = (try? await playlists.nextBatch()) ?? MusicItemCollection<Playlist>()
    }
  }
}

@MainActor
extension ChartsForType {
  private func topChartsSearch()  async {
    var components = await baseChartComponents()
    var queryItems: [URLQueryItem] = [URLQueryItem(name: "types", value: "playlists")]
    queryItems.append(URLQueryItem(name: "chart", value: "most-played"))
    queryItems.append(URLQueryItem(name: "limit", value: "100"))
    components.queryItems = queryItems
    guard let url = components.url,
          let response = try? await MusicDataRequest(urlRequest: URLRequest(url: url)).response(),
          let container = try? JSONDecoder().decode(PlaylistResponse.self, from: response.data),
          let playlists = container.results.playlists.first?.data
    else {return}
    self.playlists = playlists
  }
  
  private func baseChartComponents() async -> URLComponents {
    var components = URLComponents()
    let store = (try? await MusicDataRequest.currentCountryCode) ?? "us"
    components.scheme = "https"
    components.host = "api.music.apple.com"
    components.path = "/v1/catalog/\(store)/charts"
    return components
  }
}

fileprivate struct PlaylistResponse: Codable {
  let results: PlaylistWrapper
}
fileprivate struct PlaylistWrapper: Codable {
  let playlists: [PlaylistData]
}
fileprivate struct PlaylistData: Codable {
  let data: [Playlist]
}
fileprivate struct GenreData: Codable {
  let data: [Genre]
}
