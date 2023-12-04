import SwiftUI
import MusicKit
import Model
import PlaylistSongPreview
import ApplicationState
import Constants
import SwiftData

public struct PlaylistSongsView {
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
    let topTracksStation = TopTracksStation(playlist: playlist,
                                            buttonNumber: topTrackStations.count)
    modelContext.insert(topTracksStation)
    
    let songsInStacks = splitSongsIntoCategories(songs: songs)
    
    for category in RotationCategory.allCases {
      if let songsInCategory = songsInStacks[category] {
        let topTracksStack = TopTracksStack(category: category)
        modelContext.insert(topTracksStack)
        topTracksStation.stacks?.append(topTracksStack)
        topTracksStack.station = topTracksStation
        
        for songInCategory in songsInCategory {
          let topTracksSong = TopTracksSong(song: songInCategory)
          modelContext.insert(topTracksSong)
          topTracksStack.songs?.append(topTracksSong)
          topTracksSong.stack = topTracksStack
        }
      }
    }

//    if let stacks = topTracksStation.stacks {
//
//      for stack in stacks {
//        if let songs = stack.songs {
//          for song in songs {
//            modelContext.insert(song)
//          }
//        }
//        modelContext.insert(stack)
//      }
//
//    }
//    modelContext.insert(topTracksStation)

    //    Task {
    //      TopTracksStation.quickCreate(from: playlist,
    //                                   with: songs)
    Task {
      didCreateStation = true
      try? await Task.sleep(for: .seconds(1))
      didCreateStation = false
      
      CurrentActivity.shared.endCreating()
    }
    //
    //    }
    //  }
//    fatalError("Can't create station")
  }
}
