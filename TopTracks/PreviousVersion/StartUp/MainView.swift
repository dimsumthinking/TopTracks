import SwiftUI
import CoreData

struct MainView {
  @EnvironmentObject var topTracksStatus: TopTracksStatus
}

extension MainView : View {
  var body: some View {
    if topTracksStatus.isCreatingNew {
//      NavigationView {
      StationCreationOverview()
//        .navigationBarTitleDisplayMode(.inline)
//      }
    } else {
      StationListView()
    }
  }
}


struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
