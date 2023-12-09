import SwiftUI
import Model
import MusicKit
import Constants
import ApplicationState
import StationUpdaters

public struct StationBillboard {
  let station: TopTracksStation
  @State private var currentStation = CurrentStation.shared
  @State private var isChangingName = false
}

extension StationBillboard: View {
  public var body: some View {
    if let artwork = station.artwork,
       let backgroundColor = artwork.backgroundColor {
      HStack(alignment: isCurrentStation ? .center : .top) {
        BillboardImage(artwork: artwork)
        VStack(alignment: .leading) {
          StationNameView(station: station,
          isChangingName: $isChangingName)
          if isNotCurrentStation  {
            StationFeatured(featured: station.topSongs)
          }
        }
        if isCurrentStation {
          CurrentStationIndicator()
        }
      }
      .listRowBackground(BillboardBackground(backgroundColor: backgroundColor,
                                             isCurrentStation: isCurrentStation))      
      .swipeActions(edge: .leading, allowsFullSwipe: false) {
        ShowStacksButton(station: station)
        if !station.isChart && station.availableSongs.count > 24 {
          RotateMusicButton(station: station)
        }
        if let added = station.stack(for: .added),
           let addedSongs = added.songs,
           (!station.isChart && addedSongs.count > 4) {
          AddAndRotateMusicButton(station: station)
        }
      }
      .contentShape(Rectangle())
      .onTapGesture {
        guard isNotCurrentStation && !isChangingName else { return }
        RadioLogger.playing.info("Geting set to play \(station.name)")
        Task {
          do {
            try await UpdateRetriever.fetchUpdates(for: station)
            try await CurrentQueue.shared.playStation(station)
          } catch {
            RadioLogger.playing.info("Couldn't play \(station.name) \n \(error.localizedDescription)")
            CurrentQueue.shared.stopPlayingStation()
          }
        }
      }
      .animation(.default, value: currentStation.nowPlaying)
    }
  }
}

extension StationBillboard {
  private var isCurrentStation: Bool {
    return station == currentStation.nowPlaying
  }
  
  private var isNotCurrentStation: Bool {
    !isCurrentStation
  }
}



