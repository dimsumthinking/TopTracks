import SwiftUI
import MusicKit
import Constants
import Model

public struct StationListView {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @StateObject private var stationLister = StationLister()
  public init() {}
}

extension StationListView: View {
  public var body: some View {
    List {
      ForEach(stationLister.stations) {station in
        StationBillboard(station: station)
          .listRowInsets(EdgeInsets(top: 20, leading: 6, bottom: 20, trailing: 6))
          .swipeActions {
            Button(role: .destructive) {
              stationLister.deleteStation(station)
            }  label: {
              Image(systemName: "trash.fill")
            }
          }
      }
      
      if stationLister.stations.isEmpty {
        HStack {
          Text("Tap")
          Image(systemName: "plus")
          Text("to create a station")
          Image(systemName: "arrow.up.right")
        }
        .font(.headline)
        .foregroundColor(.yellow)
      }
    }
    .padding(.bottom, Constants.miniPlayerArtworkImageSize/2)
    .onAppear {
      stationLister.updateStationList()
    }
    .animation(.default, value: stationLister.stations)
    .listStyle(.plain)
  }
}
  
  
  struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
      StationListView()
    }
  }
