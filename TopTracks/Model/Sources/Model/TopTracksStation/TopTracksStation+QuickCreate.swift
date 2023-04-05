import MusicKit
import CoreData

extension TopTracksStation {
  public static func quickCreate(from playlist: Playlist,
                                 with songs: [Song]) {
    let context = PersistenceController.newBackgroundContext
    let station = TopTracksStation(playlist: playlist,
                             songsInStacks: splitSongsIntoCategories(songs: songs),
                             context: context)
    station.saveIfPossible()
  }
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


