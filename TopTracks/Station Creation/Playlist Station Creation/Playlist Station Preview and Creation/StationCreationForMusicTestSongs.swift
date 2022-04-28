import SwiftUI
import MusicKit
import CoreData

struct StationCreationForMusicTestSongs {
  let playlist: Playlist
  let songsInCategories: [SongInCategory]
  
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)])
  private var stations: FetchedResults<TopTracksStation>
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension StationCreationForMusicTestSongs: View {
  var body: some View {
    Button("Add station \n  \(playlist.name) + \(decorationForStationName)",
           action: createStation)
    .buttonStyle(.borderedProminent)
    .padding(.vertical)
  }
}

extension StationCreationForMusicTestSongs {
  func createStation() {
    let context = PersistenceController.newBackgroundContext
    let _ = TopTracksStation(stationName: playlist.name + decorationForStationName,
                             playlist: playlist,
                             numberOfStations: stations.count,
                             songsInCategories: songsInCategories,
                             clock: RotationClock.hourWithSpice,
                             context: context)
    do {
      topTracksStatus.endCreating()
      try context.save()
      print("tried to save \(playlist.name)")
    } catch {
      print("Not able to create a new station\n", error)
    }
  }
  
    private var decorationForStationName: String {
      let numberWithSameStart = stations.map(\.stationName)
        .filter{name in name.starts(with: playlist.name)}.count
  
      return numberWithSameStart == 0 ? "" : (" " + (numberWithSameStart + 1).description)
    }
}

//struct StationCreationForCityChart_Previews: PreviewProvider {
//  static var previews: some View {
//    StationCreationForCityChart()
//  }
//}
