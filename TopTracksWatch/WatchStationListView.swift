import SwiftUI
import WatchKit
import Model
import SwiftData

struct WatchStationListView {
  @ObservedObject private(set) var watchConnector: WatchConnector
  @Query(sort: \TopTracksStation.buttonPosition, order: .forward) var stations: [TopTracksStation]
  
}

extension WatchStationListView: View {
  var body: some View {
    List {
      ForEach(stations) { station in
        Button(station.name) {
          watchConnector.request(station: station)
        }
      }
    }
    .navigationTitle("Stations")
  }
}

#Preview {
  MainView(watchConnector: WatchConnector(action: {_ in}))
}
