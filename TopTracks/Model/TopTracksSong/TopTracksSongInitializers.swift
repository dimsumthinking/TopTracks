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
    self.songAsData = try? PropertyListEncoder().encode(song)
  }
}
