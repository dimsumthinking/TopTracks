import CoreData
import MusicKit

extension TopTracksStation {
  convenience init(stationName: String,
                   playlist: Playlist,
                   buttonPosition: Int,
                   songsAndRatings: [NewStationSongRating],
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.buttonPosition = Int16(buttonPosition)
    self.updateAvailable = false
    self.stationName = stationName
    self.stationID = UUID()
    self.favorite = false
    self.snapshots = Set<TopTracksArchivedStation>()
    self.stacks = topTracksStacks(songsAndRatings: songsAndRatings, context: context)
    self.playlistID = playlist.id.rawValue
    self.lastUpdated = Date()
    self.clockID = clockSelection(for: songsAndRatings).rawValue
  }
}

extension TopTracksStation {
  private func topTracksStacks(songsAndRatings: [NewStationSongRating],
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

extension TopTracksStation {
  private func clockSelection(for songsAndRatings: [NewStationSongRating]) -> RotationClock {
    switch songsAndRatings.filter({$0.rotationCategory == .spice}).count {
    case 0..<6:
      return .standardHour
    case 6..<12:
      return .shortHourWithSpice
    default:
      return .hourWithSpice
    }
  }

}
