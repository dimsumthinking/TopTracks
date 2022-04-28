import MusicKit
import CoreData

extension TopTracksStack {
  func add(_ addedSongs: [Song],
           context: NSManagedObjectContext) {
    var index = addedSongs.count
    for song in addedSongs {
      songs.insert(TopTracksSong(song: song,
                                 stack: self,
                                 stackPosition: index,
                                 context: context))
      index += 1
    }
  }
  
  func remove(_ songs: [Song],
              context: NSManagedObjectContext) {
fatalError()
  }
  
  func move(_ songs: [Song],
            to otherStack: TopTracksStack,
            context: NSManagedObjectContext) {
    otherStack.add(songs,
              context: context)
    remove(songs,
           context: context)
  }
}


