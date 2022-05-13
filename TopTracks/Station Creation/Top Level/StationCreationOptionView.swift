import SwiftUI

struct StationCreationOptionView {
//  let stationType: TopTracksStationType
  let stationTypeImageName: String
  let stationTypeBlurb: String
}

extension StationCreationOptionView: View {
  var body: some View {
    HStack {
      Image(systemName: stationTypeImageName)
//      Image(systemName: stationType.imageName)
        .font(.largeTitle)
      Text(stationTypeBlurb)
        .multilineTextAlignment(.center)
        .padding()
    }
    .frame(width: stationTypeCellWidth)
    .border(.secondary)
  }
}

struct StationCreationOptionView_Previews: PreviewProvider {
  static var previews: some View {
    StationCreationOptionView(stationTypeImageName: appleMusicPlaylistIcon,
                              stationTypeBlurb: "Hand-crafted from curated\nApple Music Playlist")
  }
}
