import SwiftUI

struct MainView {
  @EnvironmentObject var topTracksStatus: TopTracksStatus
}

extension MainView : View {
  var body: some View {
    Group {
      switch topTracksStatus.appActivity {
      case .playing:
        MainStationPlayerView()
      case .creating:
        MainStationCreationView()
      case .importing(let url):
        url.map{url in
          StationImporterView(url: url)
        }
      }
    }
    .onOpenURL { url in
      topTracksStatus.stopCreating()
      topTracksStatus.startImporting(url: url)
    }
  }
}
//extension MainView : View {
//  var body: some View {
//    if topTracksStatus.isCreatingNew {
//      MainStationCreationView()
//    } else {
//      MainStationPlayerView()
//    }
//  }
//}



struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
