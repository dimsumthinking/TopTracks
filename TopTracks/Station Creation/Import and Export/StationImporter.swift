import Foundation
import MusicKit

class StationImporter: ObservableObject {
  @Published var stationType: TopTracksStationType?
  @Published var musicItem: (any MusicItem)?
}

@MainActor
extension StationImporter {
  func process(url: URL)  async { //}-> (any MusicItem)? {
    let components = URLComponents(url: url,
                                   resolvingAgainstBaseURL: true)
    guard let host = components?.host,
          let musicIDString = components?.queryItems?.first?.value,
          let stationType = TopTracksStationType.stationType(from: host) else {
      self.stationType = stationTypeForDeepLinkNotFound
      return}
    self.stationType = stationType
    switch host {
    case "playlist", "dailyTop100", "cityCharts":
      musicItem =  await fetchPlaylist(musicID: musicIDString)
    case "station":
      musicItem =  await fetchStation(musicID: musicIDString)
    case "topSongs":
      musicItem = await fetchGenre(musicID: musicIDString)
    default:
      return
    }
    if musicItem == nil {
      self.stationType = stationTypeForDeepLinkNotFound
    }
  }
}

extension StationImporter {
   func musicItem(for url: URL) async -> (any MusicItem)? {
    let components = URLComponents(url: url,
                                   resolvingAgainstBaseURL: true)
    guard let host = components?.host,
          let musicID = components?.query else {return Station?.none}
    switch host {
    case "playlist", "dailyTop100", "cityCharts":
      return await fetchPlaylist(musicID: musicID)
    case "station":
      return await fetchStation(musicID: musicID)
    case "topSongs":
      return await fetchGenre(musicID: musicID)
    default:
      return Station?.none
    }
  }
}
extension StationImporter {
  private func fetchPlaylist(musicID: String) async -> Playlist? {
    let request = MusicCatalogResourceRequest<Playlist>(matching: \.id,
                                                        equalTo: MusicItemID(musicID))
    return try? await request.response().items.first
  }
  
  private func fetchStation(musicID: String) async  -> Station? {
    let request = MusicCatalogResourceRequest<Station>(matching: \.id,
                                                       equalTo: MusicItemID(musicID))
    return try? await request.response().items.first
  }
  
  private func fetchGenre(musicID: String) async -> Genre? {
    let request = MusicCatalogResourceRequest<Genre>(matching: \.id,
                                                        equalTo: MusicItemID(musicID))
    return try? await request.response().items.first
  }
  
}
//extension StationImporter {
//   func musicItem(for url: URL) async -> some MusicItem {
//    let components = URLComponents(url: url,
//                                   resolvingAgainstBaseURL: true)
//    guard let host = components?.host,
//          let musicID = components?.query else {return playlist!}
//    switch host {
//    case "playlist", "dailyTop100", "cityCharts":
//      await fetchPlaylist(musicID: musicID)
//    case "station":
//      await fetchStation(musicID: musicID)
//    case "topSongs":
//      await fetchGenre(musicID: musicID)
//    default:
//      return playlist!
//    }
//    return playlist!
//  }
//}

//extension StationImporter {
//  private func fetchPlaylist(musicID: String) async {
//    let request = MusicCatalogResourceRequest<Playlist>(matching: \.id,
//                                                        equalTo: MusicItemID(musicID))
//    playlist = try? await request.response().items.first
//  }
//
//  private func fetchStation(musicID: String) async {
//    let request = MusicCatalogResourceRequest<Station>(matching: \.id,
//                                                       equalTo: MusicItemID(musicID))
//    station = try? await request.response().items.first
//  }
//
//  private func fetchGenre(musicID: String) async {
//    let request = MusicCatalogResourceRequest<Genre>(matching: \.id,
//                                                        equalTo: MusicItemID(musicID))
//    genre = try? await request.response().items.first
//  }
//
//}

