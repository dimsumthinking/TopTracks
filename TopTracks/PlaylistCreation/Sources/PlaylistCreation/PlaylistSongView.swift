import SwiftUI
import MusicKit

public struct PlaylistSongView {
  private let playlist: Playlist
  @State private var songs = [Song]()
  
  public init(playlist: Playlist) {
    self.playlist = playlist
  }
}

extension PlaylistSongView: View {
  public var body: some View {
    List(songs) {song in
      if songs.isEmpty {
        ProgressView()
      } else {
        HStack(alignment: .top) {
          if let artwork = song.artwork {
            ArtworkImage(artwork,
                         width: Constants.songListImageSize,
                         height: Constants.songListImageSize)
          } else {
            Image(systemName: "music.note")
              .background(Color.secondary)
              .frame(width: Constants.songListImageSize,
                     height: Constants.songListImageSize)
          }
          VStack(alignment: .leading) {
            Text(song.title)
            Text(song.artistName)
              .foregroundColor(.secondary)
          }
          .padding(.leading)
        }
        .padding(.vertical)
      }
    }
    .onAppear {
      fetchSongs()
    }
  }
}


extension PlaylistSongView {
  private func fetchSongs() {
    Task {
      if let tracks = try await playlist.with([.tracks]).tracks {
        songs = tracks.compactMap { track in
          guard case Track.song(let song) = track else {return nil}
          return song
        }
      }
    }
  }
}
