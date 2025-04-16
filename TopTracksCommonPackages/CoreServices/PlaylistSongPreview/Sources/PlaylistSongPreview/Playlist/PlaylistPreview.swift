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
        List {
          Text("For best results, balance the number of songs in the top three categories - but don't exceed ten songs in each of the top four categories")
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
          ForEach(stationAllCategories) { category in
            if let stack = station.stack(for: category),
               let stacksSongs = stack.songs,
               !stacksSongs.isEmpty {
              let topTracksSongs = stack.orderedSongs
              Section {//}(category.description) {
                ForEach(topTracksSongs) {topTracksSong in
                  if let editiblePreview =
                      SongWithEditableCategoryPreview(topTracksSong: topTracksSong,
                                                      currentSong: $currentSong) {
                    HStack {
                      
                      editiblePreview
                      
                    }
                  }
                }
              } header: {
                HStack {
                  Image(systemName: category.icon)
                  Text(category.description)
                  Spacer()
                  if stationEssentialCategories.contains(category) {
                    Text(topTracksSongs.count.description)
                  }
                }
                .foregroundStyle(.primary)
                .bold()
                .font(.title2)
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
