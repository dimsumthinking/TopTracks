import SwiftUI

struct ChartTypeSelectionView {
  
}

extension ChartTypeSelectionView: View {
  var body: some View {
    VStack(spacing: 30) {
      NavigationLink {
        GenresListingView()
      } label: {
        ChartCreationOptionView(chartType: .topSongs)
      }
      NavigationLink {
        ChartListingsView(chartType: .dailyTop100)
      } label : {
        ChartCreationOptionView(chartType: .dailyTop100)
      }
      NavigationLink {
        ChartListingsView(chartType: .cityCharts)
      } label : {
        ChartCreationOptionView(chartType: .cityCharts)
      }
      NavigationLink {
        ChartListingsView(chartType: .playlists)
      } label : {
        ChartCreationOptionView(chartType: .playlists)
      }
    }
    .navigationTitle("Charts")
    .navigationBarTitleDisplayMode(.inline)
    .modifier(StationBuildCancellation())
  }
}

struct ChartTypeSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    ChartTypeSelectionView()
  }
}
