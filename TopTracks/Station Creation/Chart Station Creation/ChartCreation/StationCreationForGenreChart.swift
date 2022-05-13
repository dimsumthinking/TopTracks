import SwiftUI
import MusicKit
import CoreData

struct StationCreationForGenreChart {
  let genre: Genre
  let songsInCategories: [SongInCategory]
  
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)])
  private var stations: FetchedResults<TopTracksStation>
  @EnvironmentObject private var topTracksStatus: TopTracksStatus
  @EnvironmentObject private var currentlyPlaying: CurrentlyPlaying
}

extension StationCreationForGenreChart: View {
  var body: some View {
    if isSubscribed {
      Button("Already subscribed to \n Top Songs: \(genre.name)\n Tap to listen now",
             action: playStation)
      .padding(.vertical)
      Button("Dismiss",// \n Top Songs: \(genre.name)",
             action: topTracksStatus.stopCreating)
      .padding()
    } else {
      HStack {
      Button("Add station",// \n Top Songs: \(genre.name)",
             action: createStation)
      .padding()
      Button("Dismiss",// \n Top Songs: \(genre.name)",
             action: topTracksStatus.stopCreating)
      .padding()
      }
    }
  }
}

extension StationCreationForGenreChart {
  private var isSubscribed: Bool {
    StationCreationCheckIfExists.isSubscribed(to: genre.id,
                                                 in: stations,
                                                 chartType: .topSongs)
  }
}

extension StationCreationForGenreChart {
  func createStation() {
    topTracksStatus.stopCreating()
    StationCreation.createStation(stations: stations,
                                  genre: genre,
                                  songsInCategories: songsInCategories)
  }
}

extension StationCreationForGenreChart {
  private func playStation() {
    topTracksStatus.stopCreating()
    StationCreationCheckIfExists.playStation(with: genre.id,
                                             in: stations,
                                             chartType: .topSongs,
                                             currentlyPlaying: currentlyPlaying)
  }
}
