import CoreData
import MusicKit

extension TopTracksStation {
  convenience init(stationName: String,
                   playlist: Playlist,
                   buttonPosition: Int,
                   songsAndCategories: [MusicTestResult],
                   clock: RotationClock,
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.buttonPosition = Int16(buttonPosition)
    self.updateAvailable = false
    self.stationName = stationName
    self.stationID = UUID()
    self.favorite = false
    self.snapshots = Set<TopTracksArchivedStation>()
    self.stacks = topTracksStacks(songsAndRatings: songsAndCategories, context: context)
    self.playlistID = playlist.id.rawValue
    self.lastUpdated = Date()
    self.clockID = clock.rawValue
  }
}

extension TopTracksStation {
  private func topTracksStacks(songsAndRatings: [MusicTestResult],
                               context: NSManagedObjectContext) -> Set<TopTracksStack> {
    var topTracksStacks = Set<TopTracksStack>()
    for category in RotationCategory.allCases {
      topTracksStacks
        .insert(TopTracksStack(rotationCategory: category,
                               songs: songsAndRatings
                                .filter{$0.rotationCategory == category}
                                .map(\.song),
                               station: self,
                               context: context))
    }
    return topTracksStacks
  }
}

