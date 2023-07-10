import MusicKit
import Model

// updates non-chart playlists by checking the net for new tracks.

class PlaylistUpdater {
  
}


extension PlaylistUpdater {
  public func update(_ station: TopTracksStation) async throws {
    guard //let lastUpdated = station.playlistLastUpdated,
           let playlist = station.playlist else { return }
    Task {
      let updatedPlaylist = try await playlist.with([.tracks])
      guard let remoteLastUpdated = updatedPlaylist.lastModifiedDate,
            remoteLastUpdated > station.playlistLastUpdated else { return }
      var songs = [Song]()
      if let tracks = updatedPlaylist.tracks {
        songs = tracks.compactMap { track in
          guard case Track.song(let song) = track else {return nil}
          return song
        }
        fatalError("Station missing add songs for \(songs)")
//        station.add(songs: songs, for: playlist)
      }
    }
  }
  
  
}
