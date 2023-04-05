import SwiftUI
import PlaylistSearch
import ApplicationState
import Radio
import Players
import StationUpdaters

struct MainView {
  @State private var currentActivity = TopTracksAppActivity.enjoying
}

extension MainView: View {
  
  
  var body: some View {
    Group {
      switch currentActivity {
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
    .task {
      await registerForCurrentActivity()
    }
    .onOpenURL { url in
      CurrentActivity.shared.beginImporting(url: url)
    }
    
  }
}

extension MainView {
  private func registerForCurrentActivity() async {
    for await activity in CurrentActivity.shared.activities {
      currentActivity = activity
    }
  }
}


struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
