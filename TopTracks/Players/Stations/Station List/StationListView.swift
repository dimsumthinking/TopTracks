import SwiftUI
import MusicKit

struct StationListView {
  //  @Environment(\.managedObjectContext) private var viewContext
  //  @Environment(\.editMode) private var editMode
  @EnvironmentObject var topTracksStatus: TopTracksStatus
  @StateObject private var stationList = StationList()
//  @AppStorage("currentStationIDasString") var currentStationIDasString: String = ""
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @AppStorage("showDataWarning") private var showDataWarning = true
}

extension StationListView: View {
  var body: some View {
    List {
      if topTracksStatus.isNotConnected {
       OfflineWarningView()
      } else if topTracksStatus.isExpensive && showDataWarning {
        DataWarningView()
      }
      ForEach(stationList.stations) {station in
        StationBillboardView(station: station)//,
       // currentStationIDasString: $currentStationIDasString)
      }
      .onDelete { indexSet in
        if let index = indexSet.first {
          stationList.deleteStation(at: index,
                                    currentlyPlaying: currentlyPlaying)
        }
      }
      .onMove{ indexSet, offset in
        if let index = indexSet.first {
          stationList.moveStation(at: index, offset: offset)
        }
      }
    }
    .navigationTitle("Stations")
    .navigationBarTitleDisplayMode(.inline)
  }
}

extension StationListView {
  private func startBuilding() {
    topTracksStatus.isCreatingNew = true
  }
}

struct StationListView_Previews: PreviewProvider {
  static var previews: some View {
    StationListView()
  }
}
