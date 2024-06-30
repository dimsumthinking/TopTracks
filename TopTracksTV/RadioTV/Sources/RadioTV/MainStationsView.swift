import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import SwiftData

public struct MainStationsView: View {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @State private var isShowingSettings = false
  @State private var isShowingInfo = false
  @Environment(\.colorScheme) private var colorScheme
  @Binding var isShowingFullPlayer: Bool
  @Query(sort: \TopTracksStation.buttonPosition, order: .forward, animation: .bouncy)  var stations: [TopTracksStation]
  @State private var searchingForRandomStation: Bool = false

  public init(isShowingFullPlayer: Binding<Bool>) {
    self._isShowingFullPlayer = isShowingFullPlayer
  }
}

extension MainStationsView {
  @ViewBuilder
  public var body: some View {
    if isShowingFullPlayer {
      EmptyView()
    } else {
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
             //=========
              if stations.count > 2 {
                  Button {
                    Task {
                      searchingForRandomStation = true
                      try await CurrentQueue.shared.playRandomStation(stations)
                      try await Task.sleep(for: .seconds(2))
                      searchingForRandomStation = false
                    }
                  } label: {
                    Image(systemName: "dice")
                  }
                  .disabled(searchingForRandomStation)
              }
              
              //========
              
              
            }
            Text("Stations")
              .font(.title)
          }
          .padding()
          List {
            StationListView(isShowingFullPlayer: $isShowingFullPlayer)
            Rectangle()
              .frame(height: Constants.miniPlayerArtworkImageSize * 3 / 2)
              .foregroundColor(.clear)
            //          .listRowSeparatorTint(.clear)
          }
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
