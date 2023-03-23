import Model
import MusicKit

public class ChartUpdater {
//  private let topTracksStation: TopTracksStation
//  
//  public init(for station: TopTracksStation) {
//    self.topTracksStation = station
//  }
  
}

extension ChartUpdater {
  public func update(_ station: TopTracksStation) async throws {
    guard let lastUpdated = station.playlistLastUpdated,
           let playlist = station.playlist else { return }
    Task {
      let updatedPlaylist = try await playlist.with([.tracks])
      guard let remoteLastUpdated = updatedPlaylist.lastModifiedDate,
            remoteLastUpdated > lastUpdated else { return }
      var songs = [Song]()
      if let tracks = updatedPlaylist.tracks {
        songs = tracks.compactMap { track in
          guard case Track.song(let song) = track else {return nil}
          return song
        }
        station.updateWith(songs: songs, for: playlist)
      }
    }
  }
  
  
}
