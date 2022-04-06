import SwiftUI
import MusicKit
import CoreData

struct StationCreationForPlaylistChart {
  let chartType: TopTracksChartType
  let playlist: Playlist
  let songsInCategories: [SongInCategory]
  
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)])
  private var stations: FetchedResults<TopTracksStation>
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension StationCreationForPlaylistChart: View {
  var body: some View {
    if isSubscribed {
      Button("Already subscribed to \n \(playlist.name)",
             action: {topTracksStatus.isCreatingNew = false})
      .buttonStyle(.borderedProminent)
      .padding(.vertical)
    } else {
    Button("Subscribe to \n \(playlist.name)",
           action: createStation)
    .buttonStyle(.borderedProminent)
    .padding(.vertical)
    }
  }
}

extension StationCreationForPlaylistChart {
  private var isSubscribed: Bool {
    stations
      .filter {station in
        guard let stationType = station.stationType else {return false}
        return stationType == chartType
      }
      .map{$0.chartInfo?.sourceID ?? ""}
      .contains(playlist.id.rawValue)
  }
}

extension StationCreationForPlaylistChart {
  func createStation() {
    let context = PersistenceController.newBackgroundContext
    let _ = TopTracksStation(chartType: chartType,
                             playlist: playlist,
                             buttonPosition: stations.count,
                             songsInCategories: songsInCategories,
                             context: context)
    do {
      topTracksStatus.isCreatingNew = false
      try context.save()
      print("tried to save \(playlist.name)")
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
