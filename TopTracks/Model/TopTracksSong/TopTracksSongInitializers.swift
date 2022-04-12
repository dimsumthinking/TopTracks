import CoreData
import MusicKit

extension TopTracksSong {
  convenience init(song: Song,
                   stack: TopTracksStack,
                   stackPosition: Int,
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.currentStackPosition = stackPosition
    self.stack = stack
    self.songID = song.id.rawValue
    if let artwork = song.artwork {
      self.artworkAsData = try? PropertyListEncoder().encode(artwork)
    }
    self.songAsData = try? PropertyListEncoder().encode(song)
  }
}
