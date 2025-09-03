import SwiftUI
import MusicKit
import Model
import PlaylistSongPreview
import ApplicationState
import Constants
import SwiftData
//TODO: Look at for the TV app
public struct PlaylistSongsView: View {
  private let playlist: Playlist
  @State private var songs = [Song]()
  @State private var checkIsComplete = false
  @State private var playlistAlreadyExists = false
  @State private var existingStation: TopTracksStation?
  @State private var currentSong: Song?
  @Query private var topTrackStations: [TopTracksStation]
  
  
  public init(playlist: Playlist) {
    self.playlist = playlist
  }
}

extension PlaylistSongsView {
  public var body: some View {
    VStack {
      if checkIsComplete {
        Button("Create Station for \(playlist.name)") {
          createStation()
          CurrentActivity.shared.endCreating()
        }
        .buttonStyle(.borderedProminent)
        .disabled(songs.isEmpty || playlistAlreadyExists)
        .padding()
      }
      ScrollView {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
          ForEach(songs) {song in
            let songPreview = SongPreview(song: song,
                                          currentSong: $currentSong)
            Button {
              songPreview.playSong()
            } label: {
              HStack {
                songPreview
                Spacer()
              }.padding()
                .frame(height: Constants.songListImageSize + 40.0)
            }
          }
        }
      }
    }
    
    
    .alert("Station already Exists",
           isPresented: $playlistAlreadyExists) {
//      Button("Play the station", action: {
//        if let station = existingStation {
//          //          ApplicationState.shared.setStation(to: station)
//          Task {
//            
//            do {
//              try await CurrentQueue.shared.playStation(station)
//              try CurrentStation.shared.setStation(to: station)
//            } catch {
//              print("Couldn't play station")
//              CurrentQueue.shared.stopPlayingStation()
//              
//            }
//          }
//          
//          
//        }
//        CurrentActivity.shared.endCreating()
//        //        ApplicationState.shared.endCreating()
//      }
//      )
      Button("Cancel") {
        CurrentActivity.shared.endCreating()
        //        ApplicationState.shared.endCreating()
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
    PlaylistSearchTVLogger.creating.info("Trying to create station \(playlist.name)")
    do {
      try TopTracksStation.createStation(playlist: playlist,
                                         buttonNumber: topTrackStations.count, songs: songs)
      CurrentActivity.shared.endCreating()
    } catch {
      PlaylistSearchTVLogger.creating.info("Cannot create station \(playlist.name)")
    }
  }
}


