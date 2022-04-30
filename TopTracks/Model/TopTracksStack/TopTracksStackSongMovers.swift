import MusicKit
import CoreData

extension TopTracksStack {
  func add(_ songsToBeAdded: [Song],
           context: NSManagedObjectContext) {
    var index = songsToBeAdded.count
    for song in songsToBeAdded {
      songs.insert(TopTracksSong(song: song,
                                 stack: self,
                                 stackPosition: index,
                                 context: context))
      index += 1
    }
    try? context.save()
  }
  
  func remove(_ songsToBeRemoved: [Song],
              context: NSManagedObjectContext) {
    for song in songsToBeRemoved {
      if let topTracksSong = songs.filter({ttSong in
        ttSong.songID == song.id.rawValue
      }).first {
        songs.remove(topTracksSong)
      }
    }
    try? context.save()
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


