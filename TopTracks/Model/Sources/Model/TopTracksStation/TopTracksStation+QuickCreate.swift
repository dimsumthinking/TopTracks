import MusicKit
import CoreData

extension TopTracksStation {
  public static func quickCreate(from playlist: Playlist,
                                 with songs: [Song]) {
    let context = PersistenceController.newBackgroundContext
    let _ = TopTracksStation(playlist: playlist,
                             songsInStacks: splitSongsIntoCategories(songs: songs),
                             context: context)
    do {
      try context.save()
      print("tried to save \(playlist.name)")
    } catch {
      print("Not able to create a new station\n", error)
    }
  }
}

fileprivate func splitSongsIntoCategories(songs: [Song]) -> [RotationCategory: [Song]] {
  var songsInCategories = [RotationCategory: [Song]]()
  let proposedStackSize = songs.count.isMultiple(of: 4)   ? songs.count/4 : songs.count/4 + 1
  let stackSize = min(proposedStackSize, 10)
  songsInCategories[.power] = Array(songs[...(stackSize - 1)])
  songsInCategories[.heavy] = Array(songs[stackSize...(2 * stackSize - 1)])
  songsInCategories[.medium] = Array(songs[(2 * stackSize)...(3 * stackSize - 1)])
  songsInCategories[.light] = Array(songs[(3 * stackSize)...min(4 * stackSize - 1, songs.count - 1)])
  if songs.count > 50 {
    songsInCategories[.gold] = Array(songs[(4 * stackSize)...])
  }
  return songsInCategories
}

extension TopTracksStation {
  public static func stationForPlaylist(id: String) -> TopTracksStation? {
    let request = TopTracksStation.fetchRequest()
    request.predicate = NSPredicate(format: "playlistID == %@", id)
    
    do {
      let matchingStations = try  sharedViewContext.fetch(request) //PersistenceController.newBackgroundContext.fetch(request)
      return matchingStations.first
    } catch {
        print("Failed to return from search")
      return nil
    }
  }
}


