import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import StationUpdaters

public struct MainStationsView {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @StateObject private var stationLister = StationLister()
  @State private var isShowingSettings = false
  @State private var isShowingInfo = false
  @Environment(\.colorScheme) private var colorScheme
  public init() {}
}

extension MainStationsView: View {
  public var body: some View {
    NavigationStack {
      VStack {
        ZStack {
          HStack {
            Button {
              isShowingSettings = true
            } label: {
              Image(systemName: "gear")
            }
            Button {
              isShowingInfo = true
            } label: {
              Image(systemName: "info.circle")
            }
            Spacer()
              Button {
                CurrentActivity.shared.beginCreating()
              } label: {
                Image(systemName: "plus")
              }
            
            
          }
          Text("Stations")
            .font(.title)
        }
        .padding()
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
          //          .listRowSeparatorTint(.clear)
        }
      }
      .sheet(isPresented: $isShowingSettings) {
        SettingsView(isShowingSettings: $isShowingSettings)
          .environment(\.colorScheme, colorScheme)
      }
      .sheet(isPresented: $isShowingInfo) {
        InfoView(isShowingInfo: $isShowingInfo)
          .environment(\.colorScheme, colorScheme)
      }
      .listStyle(.plain)
    }
  }
}
