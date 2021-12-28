import SwiftUI
import MusicKit

struct AppleMusicPlaylistTracksPreviewView {
  @State var playlist: Playlist
}

extension AppleMusicPlaylistTracksPreviewView: View {
  var body: some View {
    List {
      ForEach(playlist.tracks ?? []) {track in
        if case Track.song(let song) = track {
          AppleMusicPlaylistSongPreviewView(song: song)
        }
      }
    }
    .onAppear {
      Task.detached {
        playlist = try await playlist.with([.tracks])
      }
    }
    .onDisappear {
      AppleMusicPlaylistSongPreviewView.audioPlayer = nil
    }
  }
}
