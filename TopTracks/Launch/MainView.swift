import SwiftUI
import PlaylistSearch
import ApplicationState
import Radio
import Players
import StationUpdaters

struct MainView: View {
  @State private var isCreating = false
  @EnvironmentObject private var applicationState: ApplicationState
  
  var body: some View {
    Group {
      switch applicationState.currentActivity {
      case .enjoying:
        ZStack {
          MainStationsView()
          MainPlayerView()
        }
      case .creating:  MainCreationView()
      case .viewingOrEditing(let station): MainStationSongListView(station)
      case .importing(let url):  Text("Not implemented yet for" + (url?.description ?? "no url"))
      }
    }
    
  }
}


struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
      .environmentObject(ApplicationState.shared)
  }
}
