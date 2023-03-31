import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import StationUpdaters

public struct MainStationsView {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @StateObject private var stationLister = StationLister()
  @EnvironmentObject private var applicationState: ApplicationState
  public init() {}
}

extension MainStationsView: View {
  public var body: some View {
    NavigationStack {
      List {
        StationListView(stationLister: stationLister)
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
        Rectangle()
          .frame(height: Constants.miniPlayerArtworkImageSize * 3 / 2)
          .foregroundColor(.clear)
      }
      .navigationTitle("Stations")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            ApplicationState.shared.beginCreating()
          } label: {
            Image(systemName: "plus")
          }
        }
        ToolbarItem(placement: .navigationBarLeading) {
          EditButton()
        }
      }
//      .animation(.default, value: stationLister.stations)
//      .onAppear {
//        stationLister.updateStationList()
//      }
      .listStyle(.plain)
    }
  }
}
