import MusicKit
import CoreData
import SwiftUI

struct StationCreation {
  
}

extension StationCreation {
  static func createStation(chartType: TopTracksChartType,
                            stations: FetchedResults<TopTracksStation>,
                            playlist: Playlist,
                            songsInCategories: [SongInCategory]) {
    let context = PersistenceController.newBackgroundContext
    let _ = TopTracksStation(chartType: chartType,
                             playlist: playlist,
                             numberOfStations: stations.count,
                             songsInCategories: songsInCategories,
                             context: context)
    do {
      try context.save()
      print("tried to save \(playlist.name)")
    } catch {
      print("Not able to create a new station\n", error)
    }
  }
}

extension StationCreation {
  static func createStation(stations: FetchedResults<TopTracksStation>,
                     genre: Genre,
                     songsInCategories: [SongInCategory]) {
    let context = PersistenceController.newBackgroundContext
    let _ = TopTracksStation(chartType: .topSongs,
                             genre: genre,
                             numberOfStations: stations.count,
                             songsInCategories: songsInCategories,
                             context: context)
    do {
      try context.save()
      print("tried to save \(genre.name)")
    } catch {
      print("Not able to create a new station\n", error)
    }
  }
}
