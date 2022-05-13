import MusicKit
import CoreData

extension TopTracksStation {
  var chartNeedsRefreshing: Bool {
    guard stationType.updatesDaily else {return false}
    return (Date().timeIntervalSince(lastRefreshed)) > 12 * 60 * 60 // check for update twice a day
  }
  
  func updateChart() async {
    guard let chartType = chartType,
          let sourceIDString = chartInfo?.sourceID,
          let songsInCategories = await songsForChart(chartType,
                                                    sourceID: MusicItemID(sourceIDString)),
          let context = managedObjectContext else {return}
    self.stacks = topTracksStacks(songsInCategories: songsInCategories,
                                  context: context)
    lastRefreshed = Date()
    try? context.save()
//    do {
//      try context.save()
//    } catch {
//      fatalError("Couldn't save after updating station")
//    }
  }
  
  private func songsForChart(_ chartType: TopTracksChartType,
                             sourceID musicItemID: MusicItemID) async -> [SongInCategory]? {
    switch chartType {
    case .topSongs:
      let request = MusicCatalogResourceRequest<Genre>(matching: \.id,
                                                       equalTo: musicItemID)
      guard let response = try? await request.response(),
            let genre = response.items.first else { return nil}
      return await StationFiller.rotation(for: genre)
    default:
      let request = MusicCatalogResourceRequest<Playlist>(matching: \.id,
                                                          equalTo: musicItemID)
      guard let response = try? await request.response(),
            let playlist = response.items.first else { return nil}
      return await StationFiller.rotation(for: playlist)
    }
  }
}
