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
  
//  convenience init(songs: [Song],
//                   stack: TopTracksStack,
//                   startingStackPosition: Int,
//                   context: NSManagedObjectContext = sharedViewContext) {
//    self.init(context: context)
//    for index in startingStackPosition..<songs.count {
//      stack.songs.insert(TopTracksSong(song: songs[index],
//                                       stack: stack,
//                                       stackPosition: index,
//                                       context: context))
//    }
//  }
}
