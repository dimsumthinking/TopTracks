import SwiftUI

struct MainView {
  @EnvironmentObject var topTracksStatus: TopTracksStatus
}

extension MainView : View {
  var body: some View {
    switch topTracksStatus.appActivity {
    case .playing:
      MainStationPlayerView()
    case .creating:
      MainStationCreationView()
    case .updating:
      Text("Updating view")
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
