import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import PlayersTV
import SwiftData

struct StationListView: View {
  @Binding var isShowingFullPlayer: Bool
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  private var currentStation = CurrentStation.shared.nowPlaying
  @State private var isShowingAlert: Bool = false
  @Query(sort: \TopTracksStation.lastTouched,
         order: .reverse,
         animation: .bouncy) var stations: [TopTracksStation]
  @Environment(\.modelContext) private var modelContext
  init(isShowingFullPlayer: Binding<Bool>) {
    self._isShowingFullPlayer = isShowingFullPlayer
  }
}

extension StationListView {
  @ViewBuilder
  var body: some View {
    if stations.isEmpty {
      CloudActivityView()
    }
    ForEach(stations) {station in
 
      HStack {
        StationBillboard(station: station,
                         currentStation: currentStation)
        
        if currentStation == station {
          HStack {
            Button {
              isShowingAlert = true
            } label: {
              Image(systemName: "ellipsis.circle.fill")
            }
            .buttonStyle(.card)
            .alert(station.name,
                   isPresented: $isShowingAlert,
                   presenting: station,
                   actions: {StationEditActionsView(station: $0)})

            if ApplicationMusicPlayer.shared.state.playbackStatus == .playing {
              StationPauseButton()
            } else if ApplicationMusicPlayer.shared.state.playbackStatus == .paused {
              StationPlayButton()
            }
            
              Button {
                isShowingFullPlayer = true

              } label: {
                  Image(systemName: "radio.fill")

              }
              .buttonStyle(.card)

          }
        }
      }

    }
    
      .animation(.default, value: stations)
    }
  }

extension StationListView {
  func deleteStation(_ station: TopTracksStation) {
    CurrentQueue.shared.stopPlayingDeletedStation(station)
    modelContext.delete(station)
    do {
      try modelContext.save()
    } catch {
      RadioTVLogger.stationDelete.info("Could not delete \(station.name)")
    }
  }
}

extension StationListView {
  func moveStation(from currentPosition: Int,
                   offset: Int) {
    if currentPosition < offset {
      stations[currentPosition].buttonNumber = offset - 1 // was just offset
      for (index, station) in stations.enumerated() where index > currentPosition && index < offset {
        station.buttonPosition -= 1
      }
    } else {
      stations[currentPosition].buttonNumber = offset
      for (index, station) in stations.enumerated() where index >= offset && index < currentPosition {
        station.buttonPosition += 1
      }
    }
    do {
      try modelContext.save()
    } catch {
      RadioTVLogger.stationOrder.info("Couldn't move station by dragging")
    }
  }
}





