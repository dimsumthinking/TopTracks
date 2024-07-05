import SwiftUI
import MusicKit
import ApplicationState
import PlaylistSearchShared

public struct PlaylistChooserView: View {
  @State  var lister: PlaylistLister

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
      PlaylistListView(lister.playlists )

        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Cancel") {
              CurrentActivity.shared.endCreating()
            }
          }
        }
    }
  }
}
