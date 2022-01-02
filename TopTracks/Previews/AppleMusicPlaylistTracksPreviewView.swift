import SwiftUI
import MusicKit

struct AppleMusicPlaylistTracksPreviewView {
//  let playlist: Playlist
  let songs: [Song]
}

//extension AppleMusicPlaylistTracksPreviewView: View {
//  var body: some View {
//    List {
//      ForEach(playlist.tracks ?? []) {track in
//        if case Track.song(let song) = track {
//          AppleMusicPlaylistSongPreviewView(song: song)
//        }
//      }
//    }
//    .onDisappear {
//      AppleMusicPlaylistSongPreviewView.audioPlayer = nil
//    }
//  }
//}

extension AppleMusicPlaylistTracksPreviewView: View {
  var body: some View {
    List {
      ForEach(songs) {song in
          AppleMusicPlaylistSongPreviewView(song: song)
      }
    }
    .onDisappear {
      AppleMusicPlaylistSongPreviewView.audioPlayer = nil
    }
  }
}
