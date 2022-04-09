import SwiftUI
import MusicKit

struct StationBillboardView {
  let station: TopTracksStation
  @Binding var currentStationIDasString: String
}

extension StationBillboardView: View {
  var body: some View {
    HStack {
      StationIconView(station: station)
        .frame(width: stationListCellWidth, height: stationListCellWidth, alignment: .center)
        .padding()
      Text(station.stationName)
        .multilineTextAlignment(.leading)
        .font(.title3)
        .padding(.vertical, 20)
      Spacer()
    }
    .contentShape(Rectangle())
    .onTapGesture {
      currentStationIDasString = station.stationIDAsString
    }
    .border(currentStationIDasString == station.stationIDAsString ? Color.cyan : Color.secondary.opacity(0.4),
            width: currentStationIDasString == station.stationIDAsString ? 4 : 1)
  }
}


