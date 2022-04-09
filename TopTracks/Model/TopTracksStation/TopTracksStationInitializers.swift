import CoreData
import MusicKit

extension TopTracksStation { // init for City Chart, daily top 100, and top playlist
  convenience init(chartType: TopTracksChartType,
                   playlist: Playlist,
                   buttonPosition: Int,
                   songsInCategories: [SongInCategory],
                   context: NSManagedObjectContext) {
    self.init(context: context)
    self.chartInfo  = TopTracksChartStation(chartType: chartType,
                                            playlist: playlist,
                                            station: self,
                                            context: context)
    self.buttonPosition = Int16(buttonPosition)
    self.favorite = false
    self.stationName = playlist.name + (chartType == .playlists ? " (Chart)" : "")
    self.stationID = UUID()
    self.clockID = RotationClock.hourWithSpice.rawValue
    self.lastUpdated = Date()
    self.stacks = topTracksStacks(songsInCategories: songsInCategories,
                                  context: context)
  }
}

extension TopTracksStation { // init for Genre Chart
  convenience init(chartType: TopTracksChartType,
                   genre: Genre,
                   buttonPosition: Int,
                   songsInCategories: [SongInCategory],
                   context: NSManagedObjectContext) {
    self.init(context: context)
    self.chartInfo  = TopTracksChartStation(chartType: chartType,
                                            genre: genre,
                                            station: self,
                                            context: context)
    self.buttonPosition = Int16(buttonPosition)
    self.favorite = false
    self.stationName = "Top Songs: " + genre.name
    self.stationID = UUID()
    self.clockID = RotationClock.hourWithSpice.rawValue
    self.lastUpdated = Date()
    self.stacks = topTracksStacks(songsInCategories: songsInCategories,
                                  context: context)
  }
}



extension TopTracksStation {
  convenience init(stationName: String,
                   playlist: Playlist,
                   buttonPosition: Int,
                   songsInCategories: [SongInCategory],
                   clock: RotationClock,
                   context: NSManagedObjectContext) {
    self.init(context: context)
    self.buttonPosition = Int16(buttonPosition)
    self.stationName = stationName
    self.stationID = UUID()
    self.favorite = false
    self.stacks = topTracksStacks(songsInCategories: songsInCategories,
                                  context: context)
    self.playlistInfo = TopTracksPlaylistStation(playlist: playlist,
                                                 station: self,
                                                 context: context)
    self.lastUpdated = Date()
    self.clockID = clock.rawValue
  }
}


extension TopTracksStation {
  private func topTracksStacks(songsInCategories: [SongInCategory],
                               context: NSManagedObjectContext) -> Set<TopTracksStack> {
    var topTracksStacks = Set<TopTracksStack>()
    for category in RotationCategory.allCases {
      topTracksStacks
        .insert(TopTracksStack(rotationCategory: category,
                               songs: songsInCategories
          .filter{$0.rotationCategory == category}
          .map(\.song),
                               station: self,
                               context: context))
    }
    return topTracksStacks
  }
}
