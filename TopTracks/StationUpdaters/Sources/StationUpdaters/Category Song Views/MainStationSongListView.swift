import SwiftUI
import Model
import MusicKit
import ApplicationState
import PlaylistSongPreview

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
             !stack.songs.isEmpty {
            let songs = stack.songs.compactMap(\.song).sorted{ lhs, rhs in lhs.title < rhs.title }
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
            ApplicationState.shared.endStationSongList()
          } label: {
            Text("Stations")
          }
        }
      }
      .onDisappear {
        songPreviewPlayer.stop()
      }
    }
  }
}
