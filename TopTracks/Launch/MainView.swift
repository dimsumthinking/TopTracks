import SwiftUI
import PlaylistSearch
import ApplicationState
import Radio
import Players
import PlaylistSongPreview
import Model
import SwiftData

struct MainView {
  @State private var currentActivity = CurrentActivity.shared
  @StateObject private var watchConnector = WatchConnector(action: CurrentQueue.shared.playStation)
  @Query(sort: \TopTracksStation.buttonPosition, order: .forward, animation: .bouncy) var stations: [TopTracksStation]

}

extension MainView: View {
  var body: some View {
    Group {
      switch currentActivity.appActivity {
      case .enjoying:
        ZStack {
          MainStationsView()
          MainPlayerView()
        }
      case .creating:  MainCreationView()
      case .viewingOrEditing(let station): MainStationSongListView(station)
      case .importing(let url): PlaylistImporterView(url: url)
      }
    }
    .onChange(of: stations) { oldValue, newValue in
      RadioWatchLogger.sendingStations.info("Sending \(stations.count) stations on change")

      watchConnector.setStations(to: newValue)
    }
    .onChange(of: CurrentStation.shared.nowPlaying) { oldValue, newValue in
      if let newValue {
        watchConnector.setSelectedStation(to: newValue)
      }
    }
    .onAppear {
      RadioWatchLogger.sendingStations.info("Sending \(stations.count) stations on appear")
      watchConnector.setStations(to: stations)
    }
    .onOpenURL { url in
      CurrentActivity.shared.beginImporting(url: url)
    }
  }
}


#Preview {
  MainView()
}
