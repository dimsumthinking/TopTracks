import SwiftUI
import PlaylistSearch
import ApplicationState
import Radio
import Players
import PlaylistSongPreview
import Model
import SwiftData

struct MainView: View {
  @State private var currentActivity = CurrentActivity.shared
  @StateObject private var watchConnector = WatchConnector(action: CurrentQueue.shared.playStation)
  @Query(sort: \TopTracksStation.buttonPosition, order: .forward, animation: .bouncy) var stations: [TopTracksStation]
}

extension MainView {
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
    .onChange(of: stations, initial: true) { oldValue, newValue in
      RadioWatchLogger.sendingStations.info("Sending \(stations.count) stations on change")

      watchConnector.setStations(to: newValue)
    }
    .onOpenURL { url in
      CurrentActivity.shared.beginImporting(url: url)
    }

  }
}


#Preview {
  MainView()
}
