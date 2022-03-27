import SwiftUI
import MusicKit

struct StationBillboardView {
  let station: TopTracksStation
}

extension StationBillboardView: View {
  var body: some View {
    HStack {
      Spacer()
      Text(station.stationName)
        .padding(.vertical, 20)
      Spacer()
    }
    .border(Color.secondary)
//    .frame(width: UIScreen.main.bounds.width * 2 / 3,
//           height: 60,
//           alignment: .leading)
//    .multilineTextAlignment(.leading)
    .font(.title2)
  }
}


