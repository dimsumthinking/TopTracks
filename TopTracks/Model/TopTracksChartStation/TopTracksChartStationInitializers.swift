import CoreData
import MusicKit

extension TopTracksChartStation {
  convenience init(chartType: TopTracksChartType,
                   playlist: Playlist,
                   station: TopTracksStation,
                   context: NSManagedObjectContext) {
    self.init(context: context)
    self.sourceID = playlist.id.rawValue
    print(chartType.rawValue)
    self.sourceName = playlist.name
    self.chartType = chartType.rawValue
    print(sourceName, sourceID)
  }
  convenience init(chartType: TopTracksChartType,
                   genre: Genre,
                   station: TopTracksStation,
                   context: NSManagedObjectContext) {
    self.init(context: context)
    self.sourceID = genre.id.rawValue
    self.sourceName = genre.name
    self.chartType = chartType.rawValue
  }
}
