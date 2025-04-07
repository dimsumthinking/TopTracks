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
        .onDelete { indexSet in
          if let index = indexSet.first {
            deleteStation(stations[index])
          }
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
  }
}

extension StationListView {
  func deleteStation(_ station: TopTracksStation) {
    CurrentQueue.shared.stopPlayingDeletedStation(station)
    modelContext.delete(station)
    do {
      try modelContext.save()
      for (index, station) in stations.enumerated() {
        station.buttonNumber = index
      }
      try modelContext.save()
    } catch {
      RadioLogger.stationDelete.info("Could not delete \(station.name)")
    }
  }
}




