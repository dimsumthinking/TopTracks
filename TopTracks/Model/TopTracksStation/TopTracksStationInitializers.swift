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
    
    self.stacks = topTracksStacks(songsAndRatings: songsAndRatings, context: context)
    self.playlist = TopTracksSourcePlaylist(playlist: playlist,
                                            station: self,
                                            context: context)
    self.clock = TopTracksClock(rotationClock: RotationClock.shortHourWithSpiceAndRecommendations,
                                station: self,
                                context: context)
//    for stack in self.stacks {
//      print("\n \n" + stack.stackName + "\n")
//      for song in stack.songs {
//        print(song.title)
//      }
//    }
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
