import SwiftUI
import MusicKit
import CoreData

struct StationCreationForGenreChart {
  let genre: Genre
  let songsInCategories: [SongInCategory]
  
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)])
  private var stations: FetchedResults<TopTracksStation>
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension StationCreationForGenreChart: View {
  var body: some View {
    if isSubscribed {
      Button("Already subscribed to \n Top Songs: \(genre.name)",
             action: {topTracksStatus.isCreatingNew = false})
      .buttonStyle(.borderedProminent)
      .padding(.vertical)
    } else {
      Button("Subscribe to \n Top Songs: \(genre.name)",
             action: createStation)
      .buttonStyle(.borderedProminent)
      .padding(.vertical)
    }
  }
}

extension StationCreationForGenreChart {
  private var isSubscribed: Bool {
    stations
      .filter {station in
        guard let stationType = station.chartType else {return false}
        print(stationType)
        return stationType == .topSongs
      }
      .map{$0.chartInfo?.sourceID ?? ""}
      .contains(genre.id.rawValue)
  }
}

extension StationCreationForGenreChart {
  func createStation() {
    let context = PersistenceController.newBackgroundContext
    let _ = TopTracksStation(chartType: .topSongs,
                             genre: genre,
                             buttonPosition: stations.count,
                             songsInCategories: songsInCategories,
                             context: context)
    do {
      topTracksStatus.isCreatingNew = false
      try context.save()
      print("tried to save \(genre.name)")
    } catch {
      print("Not able to create a new station\n", error)
    }
  }
  
  //  private var decorationForStationName: String {
  //    let numberWithSameStart = stations.map(\.stationName)
  //      .filter{name in name.starts(with: playlist.name)}.count
  //
  //    return numberWithSameStart == 0 ? "" : (" " + (numberWithSameStart + 1).description)
  //  }
}

//struct StationCreationForCityChart_Previews: PreviewProvider {
//  static var previews: some View {
//    StationCreationForCityChart()
//  }
//}
