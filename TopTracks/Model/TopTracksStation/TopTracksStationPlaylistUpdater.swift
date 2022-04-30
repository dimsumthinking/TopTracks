import MusicKit
import CoreData

extension TopTracksStation {
  var playlistCanBeUpdated: Bool {
    print("unrated:", numberOfUnratedSongs, "archived:", numberOfArchivedSongs)
    return numberOfUnratedSongs + numberOfArchivedSongs > 30
  }
  
  private var numberOfUnratedSongs: Int {
    guard let unratedStack = stack(.notRated) else {return 0}
    return unratedStack.songs.count
  }
  
  private var numberOfArchivedSongs: Int {
    guard let archivedStack = stack(.archived) else {return 0}
    return archivedStack.songs.count
  }
}

extension TopTracksStation {
  
}
