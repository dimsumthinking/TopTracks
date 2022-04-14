import SwiftUI

struct ChartCreationOptionView {
  let chartType: TopTracksChartType
}

extension ChartCreationOptionView: View {
  var body: some View {
    HStack {
      Image(systemName: chartType.imageName)
        .font(.largeTitle)
      Text(chartType.blurb)
        .multilineTextAlignment(.center)
        .padding()
    }

    .frame(width: chartTypeCellWidth)
    .border(.secondary)
  }
}

struct ChartCreationOptionView_Previews: PreviewProvider {
  static var previews: some View {
    ChartCreationOptionView(chartType: .dailyTop100)
  }
}
