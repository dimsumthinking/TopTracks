import SwiftUI
import MusicKit
import CoreData

struct StationCreationForPlaylistChart {
  let chartType: TopTracksChartType
  let playlist: Playlist
  let songsInCategories: [SongInCategory]
  
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)])
  private var stations: FetchedResults<TopTracksStation>
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
}

extension StationCreationForPlaylistChart: View {
  var body: some View {
    if isSubscribed {
      Button("Already subscribed to \n \(playlist.name) \n Tap to listen now",
             action: playStation)
      .padding(.vertical)
      Button("Dismiss",// \n \(playlist.name)",
             action: topTracksStatus.stopCreating)
      .padding()
    } else {
      HStack {
        Button("Add station",// \n \(playlist.name)",
               action: createStation)
        .padding()
        Button("Dismiss",// \n \(playlist.name)",
               action: topTracksStatus.stopCreating)
        .padding()
      }
    }
  }
}

extension StationCreationForPlaylistChart {
  private var isSubscribed: Bool {
    StationCreationCheckIfExists.isSubscribed(to: playlist.id,
                                              in: stations,
                                              chartType: chartType)
  }
}

extension StationCreationForPlaylistChart {
  func createStation() {
    topTracksStatus.stopCreating()
    StationCreation.createStation(chartType: chartType,
                                  stations: stations,
                                  playlist: playlist,
                                  songsInCategories: songsInCategories)
    
  }
}

extension StationCreationForPlaylistChart {
  private func playStation() {
    topTracksStatus.stopCreating()
    StationCreationCheckIfExists.playStation(with: playlist.id,
                                             in: stations,
                                             chartType: chartType,
                                             currentlyPlaying: currentlyPlaying)
  }
}
