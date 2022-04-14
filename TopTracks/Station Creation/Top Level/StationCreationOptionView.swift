import SwiftUI

struct StationCreationOptionView {
  let stationType: TopTracksStationType
}

extension StationCreationOptionView: View {
  var body: some View {
    HStack {
      Image(systemName: stationType.imageName)
        .font(.largeTitle)
      Text(stationType.blurb)
        .multilineTextAlignment(.center)
        .padding()
    }
    .frame(width: stationTypeCellWidth)
    .border(.secondary)
  }
}

struct StationCreationOptionView_Previews: PreviewProvider {
  static var previews: some View {
    StationCreationOptionView(stationType: .playlist)
  }
}
