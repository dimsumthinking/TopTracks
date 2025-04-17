import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import SwiftData

public struct MainStationsView: View {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @State private var isShowingSettings = false
  @Environment(\.colorScheme) private var colorScheme
  @Binding var isShowingFullPlayer: Bool
  @Query(sort: \TopTracksStation.buttonPosition, order: .forward, animation: .bouncy)  var stations: [TopTracksStation]

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
      .listStyle(.plain)
    }
  }
}
