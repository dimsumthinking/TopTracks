import SwiftUI
import Model
import ApplicationState
import SwiftData
import Constants
import MusicKit

struct StationListView: View {
  @Query(sort: \TopTracksStation.lastTouched,
         order: .reverse,
         animation: .bouncy)
  var stations: [TopTracksStation]
  @Environment(\.modelContext) private var modelContext
}

extension StationListView {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 375, maximum: 440))]) {
        ForEach(stations) {station in
          StationBillboard(station: station)
        }
      }
      LazyVGrid(columns: [GridItem(.flexible())]) {
        if stations.isEmpty {
          CloudActivityView()
        }
        Rectangle()
          .frame(height: Constants.miniPlayerArtworkImageSize * 3 / 2)
          .foregroundColor(.clear)
      }
    }
    .onChange(of: stations, initial: true) { _,_ in reorderButtons()}
  }
}

extension StationListView {
  private func reorderButtons() {
    do {
      for (index, station) in stations.enumerated() {
        station.buttonNumber = index
      }
      try modelContext.save()
    } catch {
      RadioLogger.stationOrder.info("Could not reorder statoins")
    }
  }
}



