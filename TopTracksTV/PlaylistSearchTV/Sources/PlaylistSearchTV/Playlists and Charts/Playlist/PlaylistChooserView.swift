import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

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
      PlaylistListView(filter(lister.playlists, using: filterString) )
//      .searchable(text: $filterString)
    }
  }
}
