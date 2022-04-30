import SwiftUI
import MusicKit

struct StationListView {
  @EnvironmentObject var topTracksStatus: TopTracksStatus
  @StateObject private var stationList = StationList()
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
  @AppStorage("showDataWarning") private var showDataWarning = true
  @AppStorage("hasAppSubscription") private var hasAppSubscription = false
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
        StationBillboardView(station: station,
                             deleteAction: stationList.delete(station: currentlyPlaying:),
                             isLocked: !hasAppSubscription && station.buttonNumber > 3)
      }
//      .onDelete { indexSet in
//        if let index = indexSet.first {
////          deleteStation(at: index)
//          stationList.deleteStation(at: index,
//                                    currentlyPlaying: currentlyPlaying)
//        }
//      }
      .onMove{ indexSet, offset in
        if let index = indexSet.first {
          stationList.moveStation(at: index, offset: offset)
        }
      }
      .onChange(of: currentlyPlaying.station) {currentStation in
        if let currentStation = currentStation {
          print("button number", currentStation.buttonNumber)
          stationList.moveStation(at: currentStation.buttonNumber - 1, offset: 0)
        }
      }
    }
    .animation(.default, value: stationList.stations)
    .navigationTitle("Stations")
    .navigationBarTitleDisplayMode(.inline)
  }
}

extension StationListView {
  private func startBuilding() {
    topTracksStatus.startCreating()
  }
//  private func deleteStation(at index: Int) {
//    stationList.deleteStation(at: index, currentlyPlaying: currentlyPlaying)
//  }
//  private func delete(station: TopTracksStation) {
//    if let stationToBeDeleted
//    stationList.deleteStation(at: index, currentlyPlaying: currentlyPlaying)
//  }
}

struct StationListView_Previews: PreviewProvider {
  static var previews: some View {
    StationListView()
  }
}
