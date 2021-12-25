import SwiftUI
import CoreData

struct MainView {
  @EnvironmentObject var buildingStatus: BuildingStatus
}

extension MainView : View {
  var body: some View {
    if buildingStatus.isBuilding {
      StationBuilderView()
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
