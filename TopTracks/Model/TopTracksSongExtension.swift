import CoreData
import MusicKit

extension TopTracksSong {
  convenience init(song: Song,
                   stack: TopTracksStack,
                   stackPosition: Int,
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.id = song.id.rawValue
    self.title = song.title
    self.artistName = song.artistName
    self.currentStackPosition = stackPosition
    self.stack = stack
  }
}
