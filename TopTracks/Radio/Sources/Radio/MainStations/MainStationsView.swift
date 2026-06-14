import SwiftUI
import ApplicationState
import MusicKit
import Players


public struct MainStationsView: View {
  @State private var isShowingFullPlayer = false
  @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue
  @State private var isShowingSettings = false
  @Environment(\.colorScheme) private var colorScheme
  public init() {}
}

extension MainStationsView {
  public var body: some View {
    NavigationStack {
        StationListView()
      .navigationTitle("Stations")
      #if !os(macOS)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          AddStationButton()
        }
        ToolbarItemGroup(placement: .navigationBarLeading) {
          ShowSettingsButton(isShowingSettings: $isShowingSettings)
        }
      }
      #endif
      .sheet(isPresented: $isShowingSettings) {
          SettingsView()
            .environment(\.colorScheme, colorScheme)
       
      }
    }
    .sheet(isPresented: $isShowingFullPlayer) {
     FullPlayerView()
    }
    .onChange(of: queue.currentEntry) { oldEntry, newEntry in
      if let newEntry {
        do {
          try CurrentSong.shared.setCurrentSong(using: newEntry)
        } catch {
          PlayersLogger.updatingSong.info("Unable to set current song to \(newEntry)")
        }
      }
    }
    .safeAreaInset(edge: .bottom) {
        MiniPlayerView()
        .onTapGesture {
          isShowingSettings = false
          isShowingFullPlayer = true
        }
    }
  }
}
