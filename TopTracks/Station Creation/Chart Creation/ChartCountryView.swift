import SwiftUI
import MusicKit

struct ChartCountryView {
  @State private var playlists: [Playlist] = []
}

extension ChartCountryView: View {
  var body: some View {
    List {
      ForEach(playlists){playlist in
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
    .navigationTitle("Daily Top 100")
    .modifier(StationBuildCancellation())
    .onAppear {
      Task {await startSearch()}
    }
  }
}

struct ChartCountryView_Previews: PreviewProvider {
  static var previews: some View {
    ChartCountryView()
  }
}



extension ChartCountryView {
  @MainActor
  private func startSearch()  async {
    let request = MusicCatalogSearchRequest(term: "Top 100:",
                                            types: [Playlist.self])
    
    let response = try? await request.response()
    guard var playlists = response?.playlists else {return}
    while playlists.hasNextBatch {
      self.playlists.append(contentsOf: playlists)
      self.playlists = Set(self.playlists).filter{playlist in playlist.isChart ?? false}
        .filter{playlist in playlist.curatorName == "Apple Music"}
        .sorted{$0.name < $1.name}
      playlists = (try? await playlists.nextBatch()) ?? MusicItemCollection<Playlist>()
    }
  }
}

extension ChartCountryView {
  private func city(for playlist: Playlist) -> String {
    playlist.name.replacingOccurrences(of: "Top 100:", with: "")
  }
}
