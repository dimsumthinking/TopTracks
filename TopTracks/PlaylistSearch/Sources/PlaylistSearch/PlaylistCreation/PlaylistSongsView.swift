import SwiftUI
import MusicKit
import Model
import PlaylistSongPreview
import ApplicationState
import Constants
import SwiftData

public struct PlaylistSongsView: View {
  private let playlist: Playlist
  @State private var songs = [Song]()
  @State private var checkIsComplete = false
  @State private var playlistAlreadyExists = false
  @State private var existingStation: TopTracksStation?
  @State private var currentSong: Song?
  @State private var didCreateStation = false
  @Query private var topTrackStations: [TopTracksStation]
  @Environment(\.modelContext) private var modelContext
  
  public init(playlist: Playlist) {
    self.playlist = playlist
  }
}

extension PlaylistSongsView {
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
          createStation()

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
      Button("Play the station") {
        if let station = existingStation {
          Task {
            do {
              try await CurrentQueue.shared.playStation(station)
              try CurrentStation.shared.setStation(to: station)
            } catch {
              print("Couldn't play station")
              CurrentQueue.shared.stopPlayingStation()
            }
          }
        }
        CurrentActivity.shared.endCreating()
      }
      Button("Cancel") {
        CurrentActivity.shared.endCreating()
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
      playlistAlreadyExists = topTrackStations.map(\.playlistID).contains(playlist.id.rawValue)
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
    PlaylistSearchLogger.creating.info("Trying to create station \(playlist.name)")
    do {
//      try TopTracksStation.createStation(playlist: playlist,
//                                         buttonNumber: topTrackStations.count, 
//                                         songs: songs)
      try TopTracksStation.createStation(from: playlist,
                                         before: topTrackStations,
                                         songs: songs)
      Task {
        didCreateStation = true
        try? await Task.sleep(for: .seconds(1))
        didCreateStation = false
        
        CurrentActivity.shared.endCreating()
      }
    } catch {
      PlaylistSearchLogger.creating.info("Cannot create station \(playlist.name)")
    }
  }
}
