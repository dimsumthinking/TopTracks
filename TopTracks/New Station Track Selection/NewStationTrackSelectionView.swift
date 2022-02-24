import SwiftUI
import MusicKit

struct NewStationTrackSelectionView {
  @State private var moveOn = false
  let playlist: Playlist
}


extension NewStationTrackSelectionView: View {
  var body: some View {
   NewStationSongSelectionView(for: playlist,
                                  moveOn: $moveOn)
      .navigationTitle(playlist.name)
    .navigationBarTitleDisplayMode(.inline)
    .modifier(StationBuildCancellation())
//    .onDisappear {
//      previewPlayer.audioPlayer = nil
//    }
  }
}

