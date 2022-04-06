import SwiftUI
import MusicKit

struct ChartListingsView {
  let chartType: TopTracksChartType
  @StateObject var chartsForType = ChartsForType()
  @State private var filterText = ""
}

extension ChartListingsView: View {
  var body: some View {
    List {
      ForEach(filteredPlaylists){playlist in
        NavigationLink {
          StationPreviewForPlaylist(chartType: chartType,
                                    playlist: playlist)
        } label: {
          HStack {
            if let artwork = playlist.artwork {
              AppleMusicPlaylistArtworkView(for: artwork)
            }
            Text(playlist.name)
              .font(.headline)
          }
        }
      }
    }
    .searchable(text: $filterText)
    .onAppear {
      chartsForType.search(for: chartType)
    }
    .navigationTitle(chartType.blurb)
    .modifier(StationBuildCancellation())
  }
}

extension ChartListingsView {
  private var filteredPlaylists: [Playlist] {
    if filterText.isEmpty {
      return chartsForType.playlists
    } else {
      return chartsForType.playlists.filter{playlist in playlist.name.lowercased().contains(filterText.lowercased())}
    }
  }
}

struct ChartListingsView_Previews: PreviewProvider {
  static var previews: some View {
    ChartListingsView(chartType: .cityCharts)
  }
}
