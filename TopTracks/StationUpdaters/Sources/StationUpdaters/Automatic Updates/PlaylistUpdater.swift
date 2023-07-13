import MusicKit
import Model
import Foundation

// updates non-chart playlists by checking Apple Music for new tracks.

class PlaylistUpdater {
  
}


extension PlaylistUpdater {
  public func update(_ station: TopTracksStation) async throws {
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
        station.add(songs: songs)
        station.playlistLastUpdated = remoteLastUpdated
        do {
          try station.context?.save()
        } catch {
          print("Couldn't update last updated date after updating")
        }
      }
    }
  }
}
