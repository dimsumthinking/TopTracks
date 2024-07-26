import SwiftUI
import Model
import Constants
import ApplicationState

public struct StationBillboard: View {
  let station: TopTracksStation
  @State private var currentStation = CurrentStation.shared
}

extension StationBillboard {
  public var body: some View {
    HStack {
        BillboardImage(artwork: station.artwork)
        StationNameView(name: station.name)//,
//                        isCurrentStation: isCurrentStation)
//        if isCurrentStation {
//          CurrentStationIndicator()
//        }
      CurrentStationIndicator(isCurrentStation: isCurrentStation)

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
        guard isNotCurrentStation else { return }
        RadioLogger.playing.info("Geting set to play \(station.name)")
        Task {
          do {
            try await station.fetchUpdates()
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

extension StationBillboard {
  private var isCurrentStation: Bool {
    return station == currentStation.nowPlaying
  }
  
  private var isNotCurrentStation: Bool {
    !isCurrentStation
  }
}

extension StationBillboard {
  private var backgroundColor: CGColor {
    if let artwork = station.artwork,
       let backgroundColor = artwork.backgroundColor {
      return backgroundColor
    } else {
      return ColorConstants.color(for: station.name)
    }
  }
}



