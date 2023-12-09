import Model
import MusicKit

public class UpdateRetriever {
  public init() {}
}

extension UpdateRetriever {
  public static func fetchUpdates(for station: TopTracksStation ) async throws {
    guard let playlist = station.playlist else { return }
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
        try station.add(songs: songs,
                        for: updatedPlaylist)
      }
      if station.isChart {
        try station.updateWith(songs: songs,
                               for: updatedPlaylist)
      } else {
        try station.add(songs: songs,
                        for: updatedPlaylist)
        
      }
    }
  }
  
}
