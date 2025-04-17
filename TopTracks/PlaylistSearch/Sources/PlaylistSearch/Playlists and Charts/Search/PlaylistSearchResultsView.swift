import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct PlaylistSearchResultsView: View {
  @State  var lister: PlaylistSearch
  @State private var filterString = ""

  init(term: String) {
    _lister = State(wrappedValue: PlaylistSearch(term: term))
  }
}
extension PlaylistSearchResultsView {
  @ViewBuilder
  public var body: some View {
    if lister.playlists.isEmpty {
      ProgressView()
    } else {
      PlaylistListView(filter(lister.playlists, using: filterString, appleOnly: false) )
      #if !os(macOS)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Cancel") {
              CurrentActivity.shared.endCreating()
            }
          }
        }
      #endif
      .searchable(text: $filterString)
    }
  }
}
