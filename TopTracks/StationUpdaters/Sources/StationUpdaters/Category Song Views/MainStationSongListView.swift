import SwiftUI
import Model
import MusicKit
import ApplicationState
import PlaylistSongPreview
import Constants

public struct MainStationSongListView {
  @State var currentSong: Song?
  let station: TopTracksStation
  
  public init(_ station: TopTracksStation) {
    self.station = station
  }
}

extension MainStationSongListView: View {
  public var body: some View {
    NavigationStack {
      VStack {
        Text(station.stationName + " Stacks")
          .font(.headline)
        List(stationStandardCategories) {category in
          if let stack = station.stack(for: category),
             let stacksSongs = stack.songs,
             !stacksSongs.isEmpty {
            let songs = stack.orderedSongs.compactMap(\.song)
            Section(category.description) {
              ForEach(songs) {song in
                SongPreview(song: song,
                            currentSong: $currentSong)
              }
            }
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(role: .cancel) {
            CurrentActivity.shared.endStationSongList()
          } label: {
            Text("Stations")
          }
        }
      }
      .onDisappear {
        songPreviewPlayer.stop()
      }
      .task {
        for await _ in NotificationCenter.default.notifications(named: Constants.previewPlayerEndsNotification).map({_ in true}) {
          currentSong = nil
        }
      }
    }
  }
}
