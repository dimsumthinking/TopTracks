import SwiftUI
import PlaylistSearchTV
import ApplicationState
import RadioTV
import PlayersTV
import StationUpdaters

struct MainView {
  @State private var currentActivity = TopTracksAppActivity.enjoying
}

extension MainView: View {
  var body: some View {
    Group {
      switch currentActivity {
      case .enjoying:
        //                ZStack {
        MainStationsView()
      case .importing:
                  MainPlayerView()
        //        }
      case .creating:  MainCreationView()
      case .viewingOrEditing(let station): MainStationSongListView(station)
      }
    }
  

    .task {
      await registerForCurrentActivity()
    }
//    .onOpenURL { url in
//      CurrentActivity.shared.beginImporting(url: url)
//    }
    
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
