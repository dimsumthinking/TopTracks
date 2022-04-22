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
      .buttonStyle(.borderedProminent)
      .padding(.vertical)
    } else {
      Button("Add station \n \(playlist.name)",
             action: createStation)
      .buttonStyle(.borderedProminent)
      .padding(.vertical)
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
    topTracksStatus.isCreatingNew = false
    StationCreation.createStation(chartType: chartType,
                                  stations: stations,
                                  playlist: playlist,
                                  songsInCategories: songsInCategories)
    
  }
}

extension StationCreationForPlaylistChart {
  private func playStation() {
    topTracksStatus.isCreatingNew = false
    StationCreationCheckIfExists.playStation(with: playlist.id,
                                             in: stations,
                                             chartType: chartType,
                                             currentlyPlaying: currentlyPlaying)
  }
}
