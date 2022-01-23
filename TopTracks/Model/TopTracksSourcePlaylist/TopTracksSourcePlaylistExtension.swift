import CoreData
import MusicKit

extension TopTracksSourcePlaylist {
  convenience init(playlist: Playlist,
                   station: TopTracksStation,
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.lastUpdated = Date()
    self.playlistAsData = try? PropertyListEncoder().encode(playlist)
    self.station = station
  }
}
