import Model
import MusicKit

public class ChartUpdater {
}

extension ChartUpdater {
  public func update(_ station: TopTracksStation) async throws {
    guard  let playlist = station.playlist else { return }
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
        try station.updateWith(songs: songs, for: playlist)
      }
    }
  }
  
  
}
