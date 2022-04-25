import SwiftUI

struct ExistingStationPreview {
  let station: TopTracksStation
  @Binding var isShowingPreview: Bool
}

extension ExistingStationPreview: View {
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Text(station.stationName)
        Spacer()
        Button("Dismiss",
               role: .cancel,
               action: {isShowingPreview = false})
      }
      .padding()
      StationSongsPreview(songsInCategories: station.songsInCategories)
    }
  }
}

//struct ExistingStationPreview_Previews: PreviewProvider {
//  static var previews: some View {
//    ExistingStationPreview()
//  }
//}
