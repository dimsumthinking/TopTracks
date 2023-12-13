import MusicKit

extension TopTracksStation {
  public func fetchUpdates() async throws {
    guard let playlist  else { return }
    Task {
      let updatedPlaylist = try await playlist.with([.tracks])
      guard let remoteLastUpdated = updatedPlaylist.lastModifiedDate,
            remoteLastUpdated > playlistLastUpdated else { return }
      var songs = [Song]()
      if let tracks = updatedPlaylist.tracks {
        songs = tracks.compactMap { track in
          guard case Track.song(let song) = track else {return nil}
          return song
        }
        try add(songs: songs,
                for: updatedPlaylist)
      }
      if isChart {
        try updateWith(songs: songs,
                       for: updatedPlaylist)
      } else {
        try add(songs: songs,
                for: updatedPlaylist)
        
      }
    }
  }
  
}
