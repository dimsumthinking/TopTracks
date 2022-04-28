import MusicKit
import CoreData

extension TopTracksStation {
  var playlistCanBeUpdated: Bool {
    numberOfUnratedSongs + numberOfArchivedSongs > 30
  }
  
  private var numberOfUnratedSongs: Int {
    guard let unratedStack
            = stacks
      .filter({stack in
        stack.stackName == RotationCategory.notRated.rawValue})
        .first else {return 0}
    return unratedStack.songs.count
  }
  private var numberOfArchivedSongs: Int {
    guard let archivedStack
            = stacks
      .filter({stack in
        stack.stackName == RotationCategory.archived.rawValue})
        .first else {return 0}
    return archivedStack.songs.count
  }
}


//  func updatePlaylist() async {
////    guard let chartType = chartType,
////          let sourceIDString = chartInfo?.sourceID,
////          let songsInCategories = await songsForChart(chartType,
////                                                    sourceID: MusicItemID(sourceIDString)),
////    let context = managedObjectContext else {return}
////    self.stacks = topTracksStacks(songsInCategories: songsInCategories,
////                                  context: context)
////    lastUpdated = Date()
////    try? context.save()
//////    do {
//////      try context.save()
//////    } catch {
//////      fatalError("Couldn't save after updating station")
//////    }
//  }
//}
  
