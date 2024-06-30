import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct PlaylistSearchResultsView: View {
  @StateObject  var lister: PlaylistSearch
  @State private var filterString = ""

  init(term: String) {
    _lister = StateObject(wrappedValue: PlaylistSearch(term: term))
  }
}
extension PlaylistSearchResultsView {
  @ViewBuilder
  public var body: some View {
    if lister.playlists.isEmpty {
      ProgressView()
    } else {
      PlaylistListView(filter(lister.playlists, using: filterString, appleOnly: false) )
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Cancel") {
              CurrentActivity.shared.endCreating()
            }
          }
        }
      .searchable(text: $filterString)
    }
  }
}
