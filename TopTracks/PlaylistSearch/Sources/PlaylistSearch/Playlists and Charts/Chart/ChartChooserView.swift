import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct ChartChooserView: View {
  @State var lister: ChartLister
//  @State private var filterString = ""
  
  init(kind: MusicCatalogChartKind) {
    _lister = State(wrappedValue: {ChartLister(kind: kind)}())
  }
}


extension ChartChooserView {
  @ViewBuilder
  public var body: some View {
    if lister.playlists.isEmpty {
      ProgressView()
    } else {
      Group {
        if lister.kind == .mostPlayed {
          PlaylistListView(lister.playlists)

//          PlaylistListView(filter(lister.playlists, using: filterString))
        } else {
          ChartListView(lister.playlists)

//          ChartListView(filter(lister.playlists, using: filterString))
        }
      }
      #if !os(macOS)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Cancel") {
              CurrentActivity.shared.endCreating()
            }
          }
        }
      #endif
//      .searchable(text: $filterString)
    }
  }
}


