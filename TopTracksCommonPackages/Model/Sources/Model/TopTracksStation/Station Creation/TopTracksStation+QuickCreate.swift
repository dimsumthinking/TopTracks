import SwiftData
import MusicKit
import Foundation

extension TopTracksStation {
  public static func createStation(playlist: Playlist,
                                   buttonNumber: Int,
                                   songs: [Song]) throws {
    let context = background.context
    let station = TopTracksStation(playlist: playlist,
                                   buttonNumber: buttonNumber)
    context.insert(station)
    createStacks(for: station,
                 songs: songs,
                 context: context)
    try context.save()
  }
  
  private static func createStacks(for station: TopTracksStation,
                                   songs: [Song],
                                  context: ModelContext) {
    let songsInCategories = splitSongsIntoCategories(songs: songs)
    for category in songsInCategories.keys {
      let stack = TopTracksStack(category: category)
      stack.station = station
      context.insert(stack)
      createSongs(for: stack,
                  songsInCategory: songsInCategories[category] ?? [Song](),
                  context: context)
    }
  }
  
  private static func createSongs(for stack: TopTracksStack,
                                  songsInCategory: [Song],
                                  context: ModelContext) {
    for song in songsInCategory {
      let topTracksSong = TopTracksSong(song: song)
      topTracksSong.stack = stack
      context.insert(topTracksSong)
    }
  }
  
}

//import MusicKit
//import CoreData
//
//extension TopTracksStation {
//  public static func quickCreate(from playlist: Playlist,
//                                 with songs: [Song]) {
//    let context = PersistenceController.newBackgroundContext
//    let station = TopTracksStation(playlist: playlist,
//                             songsInStacks: splitSongsIntoCategories(songs: songs),
//                             context: context)
//    station.saveIfPossible()
//  }
//}
//
//
//extension TopTracksStation {
//  public static func stationForPlaylist(id: String) -> TopTracksStation? {
//    let request = TopTracksStation.fetchRequest()
//    request.predicate = NSPredicate(format: "playlistID == %@", id)
//
//    do {
//      let matchingStations = try  sharedViewContext.fetch(request) //PersistenceController.newBackgroundContext.fetch(request)
//      return matchingStations.first
//    } catch {
//        print("Failed to return from search")
//      return nil
//    }
//  }
//}


