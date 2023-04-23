import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct PlaylistSearchResultsView {
  @StateObject  var lister: PlaylistSearch
  @State private var filterString = ""

  init(term: String) {
    _lister = StateObject(wrappedValue: PlaylistSearch(term: term))
  }
}
extension PlaylistSearchResultsView: View {
  public var body: some View {
    if lister.playlists.isEmpty {
      ProgressView()
    } else {
      PlaylistListView(filter(lister.playlists, using: filterString, appleOnly: false) )
//      .searchable(text: $filterString)
    }
  }
}
