import SwiftUI
import Model
import MusicKit
import ApplicationState
import Constants

public struct MainStationSongListView {
  let station: TopTracksStation
  
  public init(_ station: TopTracksStation) {
    self.station = station
  }
}

extension MainStationSongListView: View {
  public var body: some View {
    NavigationStack {
      Group {
        if station.isChart {
          ChartPreview(station)
        } else {
          PlaylistPreview(station)
        }
      }
      #if !os(macOS)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(role: .cancel) {
            CurrentActivity.shared.endStationSongList()
          } label: {
            Text("Stations")
          }
        }
      }
      #endif
      .onDisappear {
        songPreviewPlayer.stop()
      }
    }
  }
}
