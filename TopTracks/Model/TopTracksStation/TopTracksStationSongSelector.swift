import CoreData

extension TopTracksStation {
  func markAsPlayed(songID: String) {
    let context = PersistenceController.newBackgroundContext
    guard songID != (currentSongID ?? ""),
          let changedSong = fetchedSong(songID, using: context) else {return}
    changedSong.currentStackPosition = 100
    renumberStack(changedSong.stack, using: context)
    updateTime(using: context)
  }
}

extension TopTracksStation {
  fileprivate func fetchedSong(_ songID: String,
                               using context: NSManagedObjectContext) -> TopTracksSong? {
    currentSongID = songID
    let fetchRequest: NSFetchRequest<TopTracksSong> = TopTracksSong.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "%K == %@",
                                         #keyPath(TopTracksSong.songID),
                                         songID)
    var song: TopTracksSong? = nil
    do {
      song = try context.fetch(fetchRequest).first
    } catch {
      print("Searching songs error:", error)
    }
    return song
  }
}

extension TopTracksStation {
  fileprivate func printStack(_ stack: TopTracksStack) {
    print(stack.stackName)
    for song in stack.songs.sorted(by: {$0.stackPosition < $1.stackPosition}) {
      print(song.stackPosition, song.title)
    }
  }
}

extension TopTracksStation {
  fileprivate func renumberStack(_ stack: TopTracksStack,
                                 using context: NSManagedObjectContext) {
    for (index, song) in stack.songs.sorted(by: {$0.stackPosition < $1.stackPosition}).enumerated() {
      song.currentStackPosition = index
    }
    do {
      try context.save()
    } catch {
      fatalError("Couldn't renumber song positions")
    }
  }
}

extension TopTracksStation {
  fileprivate func updateTime(using context: NSManagedObjectContext)  {
    self.lastPlayed = Date()
    do {
      try context.save()
    } catch {
      fatalError("Couldn't update last played")
    }
  }
}
