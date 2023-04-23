import SwiftUI
import MusicKit
import Model
import PlaylistSongPreview
import ApplicationState
import Constants

public struct PlaylistSongsView {
  private let playlist: Playlist
  @State private var songs = [Song]()
  @State private var checkIsComplete = false
  @State private var playlistAlreadyExists = false
  @State private var existingStation: TopTracksStation?
  @State private var currentSong: Song?
  @State private var didCreateStation = false
  
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
        Button("Create Station") {
//        Button("Add \(playlist.name)") {
          createStation()
//          CurrentActivity.shared.endCreating()
        }
        .buttonStyle(.borderedProminent)
        .disabled(songs.isEmpty || playlistAlreadyExists)
        .padding()
      }
    }
    .sheet(isPresented: $didCreateStation) {
      Text("Added new station: \(playlist.name)")
        .presentationDetents([.fraction(0.25)])
        .presentationDragIndicator(.hidden)
        .interactiveDismissDisabled(true)
        .background(.thinMaterial)

    }
    
    .alert("Station already Exists",
           isPresented: $playlistAlreadyExists) {
      Button("Play the station", action: {
        // TODO: play station
        if let station = existingStation {
//          ApplicationState.shared.setStation(to: station)
          Task {
            
            do {
              try await CurrentQueue.shared.playStation(station)
              CurrentStation.shared.setStation(to: station)
            } catch {
              print("Couldn't play station")
              CurrentQueue.shared.stopPlayingStation()
              
            }
          }
          
          
        }
        CurrentActivity.shared.endCreating()
//        ApplicationState.shared.endCreating()
      })
      Button("Cancel") {
        CurrentActivity.shared.endCreating()
//        ApplicationState.shared.endCreating()
      }
    }

    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Cancel") {
          CurrentActivity.shared.endCreating()
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
    .task {
      for await _ in NotificationCenter.default.notifications(named: Constants.previewPlayerEndsNotification).map({_ in true}) {
        currentSong = nil
      }
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
    Task {
      TopTracksStation.quickCreate(from: playlist,
                                   with: songs)
      didCreateStation = true
      try? await Task.sleep(for: .seconds(2))
      didCreateStation = false
      
      CurrentActivity.shared.endCreating()
      
    }
  }
}
