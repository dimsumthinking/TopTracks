import SwiftUI
import Model
import MusicKit
import ApplicationState
import Constants

public struct PlaylistPreview {
  @State var currentSong: Song?
  let station: TopTracksStation
  let totalSongsByCategory: [RotationCategory: Int]

  
  public init(_ station: TopTracksStation) {
    self.station = station
    self.totalSongsByCategory = categoryStackSize(from: stackSizes(from: station.numberOfAvailableSongs))

  }
}

extension PlaylistPreview: View {
  public var body: some View {
    NavigationStack {
      VStack {
        Text(station.stationName + " Stacks")
          .font(.headline)
        List {
          ForEach(stationAllCategories) { category in
            if let stack = station.stack(for: category),
               let stacksSongs = stack.songs,
               !stacksSongs.isEmpty {
              let topTracksSongs = stack.orderedSongs
              Section {//}(category.description) {
                ForEach(topTracksSongs) {topTracksSong in
                      SongWithEditableCategoryPreview(topTracksSong: topTracksSong,
                                                      currentSong: $currentSong)
                }
              } header: {
                HStack {
                  Image(systemName: category.icon)
                  Text(category.description)
                  Spacer()
                  Text("\(topTracksSongs.count) /")
                  if stationEssentialCategories.contains(category) {
                    Text(totalSongsByCategory[category]?.description ?? "-")
                  } else {
                    Image(systemName: "infinity")
                  }
                }
                .foregroundStyle(.primary)
                .bold()
                .font(.subheadline)
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
