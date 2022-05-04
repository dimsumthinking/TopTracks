import CoreData
import MusicKit

extension TopTracksPlaylistStation {
  convenience init(playlist: Playlist,
                   station: TopTracksStation,
                   curator: String? = nil,
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.lastUpdated = Date()
    self.playlistID = playlist.id.rawValue
    self.playlistName = playlist.name
    if let artwork = playlist.artwork {
      self.artworkAsData = try? PropertyListEncoder().encode(artwork)
    }
    self.station = station
    self.archive = Set<TopTracksPlaylistStationArchive>()

  }
}
