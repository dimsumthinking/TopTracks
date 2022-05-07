import SwiftUI

struct AppSubscriptionButton {
  @State private var isCurrentLevel = false
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
}

extension AppSubscriptionButton: View {
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct AppSubscriptionButton_Previews: PreviewProvider {
  static var previews: some View {
    AppSubscriptionButton()
  }
}


//extension StationBillboardView: View {
//  var body: some View {
//    ZStack {
//      VStack {
//        HStack {
//          StationIconView(station: station)
//            .frame(width: stationListCellWidth, height: stationListCellWidth, alignment: .center)
//            .padding()
//          VStack (alignment: .leading){
//            Text(station.stationName)
//              .multilineTextAlignment(.leading)
//              .font(.title3)
//            if let lastUpdated = station.playlistInfo?.lastUpdated { //.station && (station.chartNeedsRefreshing || (station.playlistCanBeUpdated)) {
//              Group {
//                Text("Updated ") + Text(lastUpdated, style: .date)
//              }
//              .font(.caption)
//              .foregroundColor(.secondary)
//            }
//          }
//          Spacer()
//        }
//        .contentShape(Rectangle())
//        .onTapGesture {playStation()}
//      }
//      .border(isCurrentLevel ? Color.cyan : Color.secondary.opacity(0.4),
//              width: isCurrentStation ? 3 : 1)
//
//  }
//}
//}
//
//extension AppSubscriptionButton {
//  private var isCurrentLevel: Bool {
//    guard let currentlyPlayingStation = currentlyPlaying.station else {return false}
//    return (currentlyPlayingStation == station)
//  }
//}
//
//
//
