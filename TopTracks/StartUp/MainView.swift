import SwiftUI
import CoreData

struct MainView {
  @EnvironmentObject var stationConstructionStatus: StationContructionStatus
}

extension MainView : View {
  var body: some View {
    if stationConstructionStatus.isCreatingNew {
      StationBuilderView()
        .navigationBarTitleDisplayMode(.inline)
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
