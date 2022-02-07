import SwiftUI
import MusicKit

struct OnBoardingSongSelectionView {
  let playlist: Playlist
  @State private var moveOn = false
}

extension OnBoardingSongSelectionView: View {
  var body: some View {
    VStack {
      Text(playlist.name)
      NewStationSongSelectionView(for: playlist,
                                     moveOn: $moveOn)
        .navigationTitle("Choose the Songs")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
          previewPlayer.audioPlayer = nil
        }
    }
  }
}
