import SwiftUI
import MusicKit

struct StationBillboardView {
  let station: TopTracksStation
}

extension StationBillboardView: View {
  var body: some View {
    Text(station.stationName)
      .frame(width: UIScreen.main.bounds.width * 2 / 3,
             alignment: .leading)
      .multilineTextAlignment(.leading)
      .font(.title)
      .foregroundColor(expandedCategories[station.buttonNumber % expandedCategories.count].color)
  }
}


