import SwiftUI
import MusicKit
import Constants

public struct PlaylistChooserView {
  @StateObject  var lister: PlaylistLister
  @State private var filterString = ""

  init(category: AppleMusicCategory) {
    _lister = StateObject(wrappedValue: PlaylistLister(category: category))
  }
}


extension PlaylistChooserView: View {
  public var body: some View {
    if lister.playlists.isEmpty {
      ProgressView()
    } else {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.playlistGridGridSize,
                                               maximum: Constants.playlistGridGridSize))],
                  spacing: Constants.playlistGridRowSpacing) {
          ForEach(filteredPlaylists) {playlist in
            VStack {
              if let artwork = playlist.artwork {
                ArtworkImage(artwork,
                             width: Constants.playlistGridImageSize,
                             height: Constants.playlistGridImageSize)
              } else {
                Image(systemName: "mappin")
                  .background(Color.secondary)
                  .frame(width: Constants.playlistGridImageSize,
                         height: Constants.playlistGridImageSize)
              }
              Text(playlist.name)
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


extension PlaylistChooserView {
  var filteredPlaylists: [Playlist] {
    guard !filterString.isEmpty else {return lister.playlists.map{$0}}
    return lister.playlists.filter{$0.description.lowercased().contains(filterString.lowercased())}
  }
}



//import SwiftUI
//import MusicKit
//import Constants
//
//public struct PlaylistChooserView {
//  @StateObject  var lister: ChartLister
//
//  init(kind: MusicCatalogChartKind) {
//    _lister = StateObject(wrappedValue: ChartLister(kind: kind))
//  }
//}
//
//
//extension PlaylistChooserView: View {
//  public var body: some View {
//    if lister.playlists.isEmpty {
//      ProgressView()
//    } else {
//      ScrollView {
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.playlistGridGridSize,
//                                               maximum: Constants.playlistGridGridSize))],
//                  spacing: Constants.playlistGridRowSpacing) {
//          ForEach(lister.playlists) {chart in
//            VStack {
//              if let artwork = chart.artwork {
//                ArtworkImage(artwork,
//                             width: Constants.playlistGridImageSize,
//                             height: Constants.playlistGridImageSize)
//              } else {
//                Image(systemName: "mappin")
//                  .background(Color.secondary)
//                  .frame(width: Constants.playlistGridImageSize,
//                         height: Constants.playlistGridImageSize)
//              }
//              Text(shortenedNameFor(chart))
//              .lineLimit(1)
//              .font(.headline)
//            }
//          }
//        }
//      }
//    }
//  }
//}
//
//extension PlaylistChooserView {
//  private func shortenedNameFor(_ chart: Playlist) -> String {
//    chart.name
//      .replacingOccurrences(of: "Top 25: ", with: "")
//      .replacingOccurrences(of: "Top 100:", with: "")
//      .replacingOccurrences(of: "Daily 100:", with: "")
//  }
//}
//
//
