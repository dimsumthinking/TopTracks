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
  @State private var existingStation: TopTracksStation?
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
      Button("Play the station", action: {
        // TODO: play station
        if let station = existingStation {
//          ApplicationState.shared.setStation(to: station)
          Task {
            do {
              try await ApplicationState.shared.playStation(station)
            } catch {
              print("Couldn't play station")
              ApplicationState.shared.noStationSelected()
              
            }
          }
          
          
        }
        ApplicationState.shared.endCreating()
      })
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
      existingStation =
        TopTracksStation.stationForPlaylist(id: playlist.id.rawValue)
      playlistAlreadyExists = (existingStation != nil)
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
