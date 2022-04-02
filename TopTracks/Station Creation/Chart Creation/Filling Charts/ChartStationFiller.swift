import MusicKit
import Foundation

struct ChartStationFiller {}

extension ChartStationFiller {
  static func rotation(for playlist: Playlist) async -> [SongInCategory] {
    guard let playlistWithTracks = try? await playlist.with([.tracks]),
          let tracks = playlistWithTracks.tracks else {fatalError("cant find songs")}
    var songs = tracks.compactMap { (track: Track) -> Song? in
      guard case Track.song(let song) = track else {return nil}
      return song
    }
    if let isChart = playlist.isChart,
       isChart == false {
      songs = songs.shuffled()
    }
    
    return songs.splitSongs
  }
  
  static func rotation(for genre: Genre) async -> [SongInCategory] {
    var components = await baseChartComponents()
    var queryItems: [URLQueryItem] = [URLQueryItem(name: "types", value: "songs")]
    queryItems.append(URLQueryItem(name: "chart", value: "most-played"))
    queryItems.append(URLQueryItem(name: "genre", value: genre.id.rawValue))
    queryItems.append(URLQueryItem(name: "limit", value: "40"))
    components.queryItems = queryItems
    guard let url = components.url,
          let response = try? await MusicDataRequest(urlRequest: URLRequest(url: url)).response(),
          let container = try? JSONDecoder().decode(SongsResponse.self, from: response.data),
          let songs = container.results.songs.first?.data
    else {return []}
    return songs.splitSongs
  }
}


extension ChartStationFiller {
  private static func baseChartComponents() async -> URLComponents {
    var components = URLComponents()
    let store = (try? await MusicDataRequest.currentCountryCode) ?? "us"
    components.scheme = "https"
    components.host = "api.music.apple.com"
    components.path = "/v1/catalog/\(store)/charts"
    return components
  }
}



fileprivate extension Array where Element == Song {
  var splitSongs: [SongInCategory] {
    let stationSize = Swift.min(count, 40)
    let segmentSize = stationSize / 4
    let sizeMod4 = stationSize % 4
    let break1 = segmentSize + ((sizeMod4 > 0) ? 1 : 0)
    let break2 = segmentSize + break1 + ((sizeMod4 > 1) ? 1 : 0)
    let break3 = segmentSize + break2 + ((sizeMod4 > 2) ? 1 : 0)
    
    return self[0..<break1].map{SongInCategory(for: $0, rotationCategory: .power)}
    + self[break1..<break2].map{SongInCategory(for: $0, rotationCategory: .current)}
    + self[break2..<break3].map{SongInCategory(for: $0, rotationCategory: .added)}
    + self[break3..<stationSize].map{SongInCategory(for: $0, rotationCategory: .spice)}
    
//    return [Array(self[0..<break1]),
//            Array(self[break1..<break2]),
//            Array(self[break2..<break3]),
//            Array(self[break3..<stationSize])]
    
  }
}



fileprivate struct SongsResponse: Codable {
  let results: SongsWrapper
}
fileprivate struct SongsWrapper: Codable {
  let songs: [SongsData]
}
fileprivate struct SongsData: Codable {
  let data: [Song]
}
