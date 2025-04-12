import SwiftUI
import Model
import MusicKit
import ApplicationState
import Constants

public struct PlaylistPreview {
  @State var currentSong: Song?
  let station: TopTracksStation
  
  public init(_ station: TopTracksStation) {
    self.station = station
  }
}

extension PlaylistPreview: View {
  public var body: some View {
    NavigationStack {
      VStack {
        Text(station.stationName + " Stacks")
          .font(.headline)
        List(stationAllCategories) {category in
          if let stack = station.stack(for: category),
             let stacksSongs = stack.songs,
             !stacksSongs.isEmpty {
            let topTracksSongs = stack.orderedSongs
            Section(category.description) {
              ForEach(topTracksSongs) {topTracksSong in
                if let editiblePreview =
                    SongWithEditableCategoryPreview(topTracksSong: topTracksSong,
                                                    currentSong: $currentSong) {
                  HStack {
                    
                    editiblePreview
                    
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
