import SwiftUI
import MusicKit
import Model
import PlaylistSongPreview
import ApplicationState

public struct PlaylistSongsView {
  private let playlist: Playlist
  @State private var songs = [Song]()
  @State private var checkIsComplete = false
  @State private var playlistAlreadyExists = false
  @State private var currentSong: Song?
  
  public init(playlist: Playlist) {
    self.playlist = playlist
  }
}

extension PlaylistSongsView: View {
  public var body: some View {
    VStack {
      List(songs) {song in
        if songs.isEmpty {
          ProgressView()
        } else {
          SongPreview(song: song,
                      currentSong: $currentSong)
        }
      }
      if checkIsComplete {
        Button("Add \(playlist.name)") {
          createStation()
          ApplicationState.shared.endCreating()
        }
        .buttonStyle(.borderedProminent)
        .disabled(songs.isEmpty || playlistAlreadyExists)
        .padding(.top)
      }
    }
    .alert("Station already Exists",
           isPresented: $playlistAlreadyExists) {
      Button("Play the station", action: {})
      Button("Cancel") {
        ApplicationState.shared.endCreating()
      }
    }

    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Cancel") {
          ApplicationState.shared.endCreating()
        }
      }
    }
    .onAppear {
      playlistAlreadyExists =
        TopTracksStation.stationExistsForPlaylist(id: playlist.id.rawValue)
      checkIsComplete = true
      fetchSongs()
    }
    .onDisappear {
      songPreviewPlayer.stop()
    }
  }
}


extension PlaylistSongsView {
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

extension PlaylistSongsView {
  func createStation() {
    TopTracksStation.quickCreate(from: playlist,
                                 with: songs)
  }
}
