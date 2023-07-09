//import CoreData
//import MusicKit
//
//
//extension TopTracksStation {
//  convenience init(playlist: Playlist,
//                   songsInStacks: [RotationCategory: [Song]],
//                   context: NSManagedObjectContext) {
//    self.init(context: context)
//    self.favorite = false
//    self.stationLastUpdated = Date()
//    self.playlistLastUpdated = playlist.lastModifiedDate
//    self.playlistID = playlist.id.rawValue
//    self.stationID = UUID()
//    self.stationName = playlist.name
//    self.updateAvailable = false
//    self.lastTouched = Date()
//    self.allowRecommendations = true
//    self.playlistAsData = try? PropertyListEncoder().encode(playlist)
//    self.stacks = topTracksStacks(songsInStacks: songsInStacks,
//                                  context: context)
//    self.isChart = playlist.isChart ?? false
//    let numberOfStations: Int
//    do {
//      numberOfStations = try context.count(for: TopTracksStation.fetchRequest())
//    } catch {
//      numberOfStations = 0
//    }
//    self.buttonPosition = Int16(numberOfStations)
//    self.stacksLastRotated = Date()
//  }
//}
//
//extension TopTracksStation {
//  private func topTracksStacks(songsInStacks: [RotationCategory: [Song]],
//                               context: NSManagedObjectContext) -> Set<TopTracksStack> {
//    var topTracksStacks = Set<TopTracksStack>()
//    for category in RotationCategory.allCases {
//      let songs = songsInStacks[category] ?? [Song]()
//      topTracksStacks.insert(TopTracksStack(category: category,
//                                            songs: songs,
//                                            station: self,
//                                            context: context))
//      print("Stack", category, "\n \t", songs.count.description)
//    }
//    return topTracksStacks
//  }
//  
//}
//
