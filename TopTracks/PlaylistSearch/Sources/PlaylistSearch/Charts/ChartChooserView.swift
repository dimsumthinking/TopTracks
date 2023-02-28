import SwiftUI
import MusicKit
import Constants

public struct ChartChooserView {
  @StateObject  var lister: ChartLister
  @State private var filterString = ""
  
  init(kind: MusicCatalogChartKind) {
    _lister = StateObject(wrappedValue: ChartLister(kind: kind))
  }
}


extension ChartChooserView: View {
  public var body: some View {
    if lister.playlists.isEmpty {
      ProgressView()
    } else {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.playlistGridGridSize,
                                               maximum: Constants.playlistGridGridSize))],
                  spacing: Constants.playlistGridRowSpacing) {
          ForEach(filteredPlaylists) {chart in
            VStack {
              if let artwork = chart.artwork {
                ArtworkImage(artwork,
                             width: Constants.playlistGridImageSize,
                             height: Constants.playlistGridImageSize)
              } else {
                Image(systemName: "mappin")
                  .background(Color.secondary)
                  .frame(width: Constants.playlistGridImageSize,
                         height: Constants.playlistGridImageSize)
              }
              Text(shortenedNameFor(chart))
              .lineLimit(1)
              .font(.headline)
            }
          }
        }
      }
      .searchable(text: $filterString)
    }
  }
}

extension ChartChooserView {
  private func shortenedNameFor(_ chart: Playlist) -> String {
    chart.name
      .replacingOccurrences(of: "Top 25: ", with: "")
      .replacingOccurrences(of: "Top 100:", with: "")
      .replacingOccurrences(of: "Daily 100:", with: "")
  }
}


extension ChartChooserView {
  var filteredPlaylists: [Playlist] {
    guard !filterString.isEmpty else {return lister.playlists.map{$0}}
    return lister.playlists.filter{$0.description.lowercased().contains(filterString.lowercased())}
  }
}
