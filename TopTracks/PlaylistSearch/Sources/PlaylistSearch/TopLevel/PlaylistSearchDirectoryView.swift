import SwiftUI
import MusicKit

public struct PlaylistSearchDirectoryView {
  public init() {
  }
}

extension PlaylistSearchDirectoryView: View {
  public var body: some View {
    NavigationStack {
      Grid(alignment: .leading) {
        ForEach(PlaylistKind.allCases) { playlistKind in
          NavigationLink(value: playlistKind) {
            GridRow {
              Image(systemName: playlistKind.sfSymbolName)
              Text(playlistKind.description)
            }
            .font(.title2)
            .padding(.bottom)
          }
        }
      }
      .navigationTitle("Playlist Categories")
      .navigationBarTitleDisplayMode(.inline)
      .navigationDestination(for: PlaylistKind.self) { kind in
        if kind.isChart {
          ChartChooserView(kind: kind.musicCatalogChartKind)
            .navigationTitle(kind.description)
        } else {
          AppleMusicCategoryChooserView(categories: kind.playlistCategories)
            .navigationTitle(kind.description)
        }
      }
    }
  }
}

struct PlaylistSearchDirectoryView_Previews: PreviewProvider {
  static var previews: some View {
      PlaylistSearchDirectoryView()
  }
}
//extension PlaylistSearchDirectoryView: View {
//  public var body: some View {
//    NavigationStack {
//      ForEach(MusicCatalogChartKind.allCases) { chartType in
//        NavigationLink {
//          ChartChooserView(kind: chartType)
//            .navigationTitle(chartType.blurb)
//        }  label: {
//          ChartTypeLabel(chartType: chartType)
//        }
//      }
//    }
//  }
//}




