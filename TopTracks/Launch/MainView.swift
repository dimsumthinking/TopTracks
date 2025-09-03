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
      }
    }

  }
}


#Preview {
  MainView()
}
