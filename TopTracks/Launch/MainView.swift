import SwiftUI

struct MainView {
  @EnvironmentObject var topTracksStatus: TopTracksStatus
//  private var currentlyPlaying = CurrentlyPlaying()
}

extension MainView : View {
  var body: some View {
    if topTracksStatus.isCreatingNew {
      MainStationCreationView()
    } else {
      MainStationPlayerView()
//        .environmentObject(currentlyPlaying)
//      StationsView()
    }
  }
}


struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

import MusicKit

//extension MainView {
//  @MainActor
//  private func startSearch()  async {
//    var components = URLComponents()
//    components.scheme = "https"
//    components.host = "api.music.apple.com"
//    components.path = "/v1/catalog/us/charts"
//    var queryItems: [URLQueryItem] = [URLQueryItem(name: "types", value: "songs")]
//    queryItems.append(URLQueryItem(name: "chart", value: "most-played"))
//    queryItems.append(URLQueryItem(name: "genre", value: "24"))
//    components.queryItems = queryItems
//    if let url = components.url {
//    var request = MusicDataRequest(urlRequest: URLRequest(url: url))
//      let response = try? await request.response()
//      print(response)
//    }
//  }
//}

//extension MainView {
//  @MainActor
//  private func startSearch()  async {
//    var components = URLComponents()
//    components.scheme = "https"
//    components.host = "api.music.apple.com"
//    components.path = "/v1/catalog/us/genres"
////    var queryItems: [URLQueryItem] = [URLQueryItem(name: "types", value: "songs")]
////    queryItems.append(URLQueryItem(name: "chart", value: "most-played"))
////    queryItems.append(URLQueryItem(name: "genre", value: "24"))
////    components.queryItems = queryItems
//    if let url = components.url {
//    var request = MusicDataRequest(urlRequest: URLRequest(url: url))
//      let response = try? await request.response()
//      
//      print(response)
//      print("OK")
//    }
//  }
//}

//
//extension MainView {
//  @MainActor
//  private func startSearch()  async {
//    var totalPlaylists: [Playlist] = []
//    let request = MusicCatalogSearchRequest(term: "chart=most-played",
//                                            types: [Playlist.self])
//
//    let response = try? await request.response()
//    guard var playlists = response?.playlists else {return}
//    while playlists.hasNextBatch {
//      totalPlaylists.append(contentsOf: playlists)
//      totalPlaylists = Set(totalPlaylists).filter{playlist in playlist.isChart ?? false}
//        .filter{playlist in playlist.curatorName == "Apple Music"}
//        .sorted{$0.name < $1.name}
//      playlists = (try? await playlists.nextBatch()) ?? MusicItemCollection<Playlist>()
//    }
//
//
//
//    print("Number of playlists:", totalPlaylists.count)
//    for playlist in totalPlaylists  {
//      print(playlist.name)
//    }
//  }
//}
