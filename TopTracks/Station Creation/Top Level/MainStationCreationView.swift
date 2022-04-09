import SwiftUI

struct MainStationCreationView {
  
}

extension MainStationCreationView: View {
  var body: some View {
    NavigationView {
      VStack(spacing: 30) {
        NavigationLink {
         ChartTypeSelectionView()
        } label: {
          StationCreationOptionView(stationType: .chart)
        }
        NavigationLink {
         AppleMusicCategoryChooserView()
        } label : {
          StationCreationOptionView(stationType: .playlist)
        }
      }
      .navigationTitle("Station Type")
      .navigationBarTitleDisplayMode(.inline)
      .navigationViewStyle(.stack)
      .modifier(NewStationCancellation())
    }
  }
}

struct MainStationCreationView_Previews: PreviewProvider {
  static var previews: some View {
    MainStationCreationView()
  }
}
