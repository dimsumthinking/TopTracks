import SwiftUI
import MusicKit

struct ChartCityView {
//  @State private var playlists: [Playlist] = []
  @StateObject var chartsForType = ChartsForType()
}

extension ChartCityView: View {
  var body: some View {
    List {
      ForEach(chartsForType.playlists){playlist in
        NavigationLink {
          Text("One")
        } label: {
          HStack {
            if let artwork = playlist.artwork {
              AppleMusicPlaylistArtworkView(for: artwork)
            }
            Text(city(for: playlist))
              .font(.headline)
          }
        }
      }
    }
    .navigationTitle("City Charts")
    .modifier(StationBuildCancellation())
//    .onAppear {
//      Task {await startSearch()}
//    }
  }
}

struct ChartCityView_Previews: PreviewProvider {
  static var previews: some View {
    ChartCityView()
  }
}


//
//extension ChartCityView {
//  @MainActor
//  private func startSearch()  async {
//    let request = MusicCatalogSearchRequest(term: "Top 25:",
//                                            types: [Playlist.self])
//
//    let response = try? await request.response()
//    guard var playlists = response?.playlists else {return}
//    while playlists.hasNextBatch {
//      self.playlists.append(contentsOf: playlists)
//      self.playlists = Set(self.playlists).filter{playlist in playlist.isChart ?? false}
//        .filter{playlist in playlist.curatorName == "Apple Music"}
//        .sorted{$0.name < $1.name}
//      playlists = (try? await playlists.nextBatch()) ?? MusicItemCollection<Playlist>()
//    }
//  }
//}

extension ChartCityView {
  private func city(for playlist: Playlist) -> String {
    playlist.name.replacingOccurrences(of: "Top 25:", with: "")
  }
}
