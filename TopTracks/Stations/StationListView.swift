import SwiftUI

struct StationListView {
  @EnvironmentObject var buildingStatus: BuildingStatus
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "timestamp",
                                                   ascending: true)]) var stations: FetchedResults<TopTracksStation>
}

extension StationListView: View {
  var body: some View {
    NavigationView {
      if stations.isEmpty {promptToCreateStation}
      else {listAllStations.toolbar {addStationButton}}
    }
  }
}

extension StationListView {
  private var promptToCreateStation: some View {
    Button("Create your first Station",
           action: startBuilding)
  }

  private var listAllStations: some View {
    List {
      ForEach(stations, id: \.self) {station in
        Text("Station \(station)")
      }
    }
    .navigationTitle("Stations")
  }

  private var addStationButton: ToolbarItem<Void, Button<Image>> {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: startBuilding) {
        Image(systemName: "plus")
      }
    }
  }
}


extension StationListView {
  private func startBuilding() {
    buildingStatus.isBuilding = true
  }
}

struct StationListView_Previews: PreviewProvider {
  static var previews: some View {
    StationListView()
  }
}
