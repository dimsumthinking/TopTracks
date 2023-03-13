import SwiftUI
import MusicKit
import ApplicationState

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
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Cancel") {
              ApplicationState.shared.endCreating()
            }
          }
        }
      .searchable(text: $filterString)
    }
  }
}