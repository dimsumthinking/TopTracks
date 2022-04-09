import SwiftUI
import MusicKit

struct StationListView {
  //  @Environment(\.managedObjectContext) private var viewContext
  //  @Environment(\.editMode) private var editMode
  @EnvironmentObject var topTracksStatus: TopTracksStatus
  @StateObject private var stationList = StationList()
  @AppStorage("currentStationIDasString") var currentStationIDasString: String = ""
}

extension StationListView: View {
  var body: some View {
    List {
      ForEach(stationList.stations) {station in
        StationBillboardView(station: station,
        currentStationIDasString: $currentStationIDasString)
      }
      .onDelete { indexSet in
        if let index = indexSet.first {
          stationList.deleteStation(at: index)
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
