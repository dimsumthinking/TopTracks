import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct PlaylistChooserView: View {
  @State var lister: PlaylistLister
  @State private var filterString = ""

  init(category: AppleMusicCategory) {
    _lister = State(wrappedValue: PlaylistLister(category: category))
  }
}
extension PlaylistChooserView {
  @ViewBuilder
  public var body: some View {
    if lister.playlists.isEmpty {
      ProgressView()
    } else {
      PlaylistListView(filter(lister.playlists, using: filterString) )
//      .searchable(text: $filterString)
    }
  }
}
