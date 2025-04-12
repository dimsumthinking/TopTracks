import SwiftUI
import Model
import MusicKit
import ApplicationState
import Constants

public struct ChartPreview {
  @State var currentSong: Song?
  let station: TopTracksStation
  
  public init(_ station: TopTracksStation) {
    self.station = station
  }
}

extension ChartPreview: View {
  public var body: some View {
    NavigationStack {
      VStack {
        Text(station.stationName + " Stacks")
          .font(.headline)
        List(stationAllCategories) {category in
          if let stack = station.stack(for: category),
             let stacksSongs = stack.songs,
             !stacksSongs.isEmpty {
            let songs = stack.orderedSongs.compactMap(\.song)
            Section(category.description) {
              ForEach(songs) {song in
                HStack {
                  SongPreview(song: song,
                              currentSong: $currentSong)
                  if !station.isChart {
                    Text("Is not a chart")
                  }
                }
              }
            }
          }
        }
      }
      .task {
        for await _ in NotificationCenter.default.notifications(named: Constants.previewPlayerEndsNotification).map({_ in true}) {
          currentSong = nil
        }
      }
    }
  }
}
