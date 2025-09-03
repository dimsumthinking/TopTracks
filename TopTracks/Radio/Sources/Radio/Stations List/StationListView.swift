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
  @State private var searchFilter = ""
}

extension StationListView {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 375, maximum: 440))]) {
        ForEach(filteredStations) {station in
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
    .searchable(text: $searchFilter, placement: .navigationBarDrawer)
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

extension StationListView {
  private var filteredStations: [TopTracksStation] {
    guard !searchFilter.isEmpty else {
      return stations
    }
    return stations.filter { station in
      station.name.localizedCaseInsensitiveContains(searchFilter)
    }
  }
}



