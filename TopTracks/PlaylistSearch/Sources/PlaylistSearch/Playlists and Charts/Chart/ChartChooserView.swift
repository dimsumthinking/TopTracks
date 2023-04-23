import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct ChartChooserView {
  @StateObject  var lister: ChartLister
  @State private var filterString = ""
  
  init(kind: MusicCatalogChartKind) {
    _lister = StateObject(wrappedValue: {ChartLister(kind: kind)}())
  }
}


extension ChartChooserView: View {
  public var body: some View {
    if lister.playlists.isEmpty {
      ProgressView()
    } else {
      PlaylistListView(filter(lister.playlists, using: filterString))
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Cancel") {
              CurrentActivity.shared.endCreating()
//              ApplicationState.shared.endCreating()
            }
          }
        }
      .searchable(text: $filterString)
    }
  }
}

