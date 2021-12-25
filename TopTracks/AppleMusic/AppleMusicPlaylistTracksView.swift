import SwiftUI
import MusicKit

struct AppleMusicPlaylistTracksView {
  @State var playlist: Playlist
}

extension AppleMusicPlaylistTracksView: View {
  var body: some View {
    List {
      ForEach(playlist.tracks ?? []) {track in
        if case Track.song(let song) = track {
          AppleMusicPlaylistSongView(song: song)
        }
      }
    }
    .modifier(InfoModifier(message: ""))
    .onAppear {
      Task.detached {
        playlist = try await playlist.with([.tracks])
      }
    }
  }
}

