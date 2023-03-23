import CoreData
import MusicKit

extension TopTracksStation {
  public func updateWith(songs songsToAdd: [Song],
                         for playlist: Playlist) {
    guard let managedObjectContext,
    let playlistAsData = try? PropertyListEncoder().encode(playlist) else { return }
    self.playlistAsData = playlistAsData
    stationLastUpdated = Date()
    playlistLastUpdated = playlist.lastModifiedDate
    var newStacks = splitSongsIntoCategories(songs: songsToAdd)
    for song in activeSongs { // moves or deletes current songs
      let (category, returnedSongs) = categoryFor(songTitle: song.title, in: newStacks)
      if let category = category {
        changeStack(for: song, to: category)
        newStacks[category] = returnedSongs
      } else {
        managedObjectContext.delete(song)
      }
    }
    
    stacks.forEach { topTracksStack in // add remaining songs to station
      if let categorySongs = newStacks[topTracksStack.rotationCategory] {
        for song in categorySongs {
          topTracksStack.addToSongs(TopTracksSong(song: song,
                                                  stack: topTracksStack,
                                                  context: managedObjectContext))
        }
      }
    }
    saveIfPossible()
  }
  
  func categoryFor(songTitle: String, in categorizedSongs: [RotationCategory: [Song]] ) -> (RotationCategory?, [Song]) {
    var songsCategory: RotationCategory? = nil
    var returnedSongs: [Song] = []
    for (category, songsInCategory) in categorizedSongs {
      let titles = songsInCategory.map(\.title)
      if titles.contains(songTitle) {
        songsCategory = category
        if let index = titles.firstIndex(of: songTitle) {
          var songsInCategory = songsInCategory
          songsInCategory.remove(at: index)
          returnedSongs = songsInCategory
        }
        
      }
    }
    return (songsCategory, returnedSongs)
  }
  
}


extension TopTracksStation {
  func report(message: String = "") {
    print(message)
    self.stacks.forEach { stack in
      print(stack.name, stack.songs.count.description, stack.songs.map(\.title).sorted())
    }

  }
}
