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
          StationCreationOptionView(stationTypeImageName: appleMusicChartIcon,
                                    stationTypeBlurb: appleMusicChartBlurb)
        }
        NavigationLink {
         AppleMusicCategoryChooserView()
        } label : {
          StationCreationOptionView(stationTypeImageName: appleMusicPlaylistIcon,
                                    stationTypeBlurb: appleMusicPlaylistBlurb)

        }
        NavigationLink {
         AppleMusicStationChooserView()
        } label : {
          StationCreationOptionView(stationTypeImageName: appleMusicStationIcon,
                                    stationTypeBlurb: appleMusicStationBlurb)
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
