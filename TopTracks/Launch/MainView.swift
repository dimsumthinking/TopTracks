import SwiftUI
import PlaylistSearch
import ApplicationState
import Radio
import Players
import StationUpdaters
import PlaylistSongPreview

struct MainView {
  @State private var currentActivity = CurrentActivity.shared
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
    .onOpenURL { url in
      CurrentActivity.shared.beginImporting(url: url)
    }
  }
}


#Preview {
  MainView()
}
