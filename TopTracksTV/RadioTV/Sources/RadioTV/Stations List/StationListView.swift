import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import PlayersTV
import SwiftData

struct StationListView {
  @Binding var isShowingFullPlayer: Bool
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  private var currentStation = CurrentStation.shared.nowPlaying
  @State private var isShowingAlert: Bool = false
  @Query(sort: \TopTracksStation.buttonPosition, order: .forward, animation: .bouncy) var stations: [TopTracksStation]
  @Environment(\.modelContext) private var modelContext
  init(isShowingFullPlayer: Binding<Bool>) {
    self._isShowingFullPlayer = isShowingFullPlayer
  }
}

extension StationListView: View {
  var body: some View {
    
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
            .alert("\(station.name) Actions", isPresented: $isShowingAlert) {
              Button("Delete", role: .destructive) {
                deleteStation(station)
              }
              Button("Station Playlist") {
                CurrentActivity.shared.beginStationSongList(for: station)
              }
              
              if !station.isChart && station.availableSongs.count > 24 {
                Button("Rotate Music") {
                  do {
                    try station.rotate()
                  } catch {
                    RadioTVLogger.stationMusicRotator.info("Couldn't rotate the music for \(station.stationName)")
                  }
                }
              }
              if let added = station.stack(for: .added),
                 let addedSongs = added.songs,
                 (!station.isChart && addedSongs.count > 4) {
                Button("Add New Music and Rotate") {
                  do {
                    try station.addAndRotate()
                  }
                  catch { RadioTVLogger.stationMusicRotator.info("Couldn't add rotate the music for \(station.stationName)")
                  }
                }
              }
            }
            VStack {
              
              
              if station.buttonNumber > 0 {
                Button {
                  moveStation(from: station.buttonNumber,
                              offset: station.buttonNumber - 1)
                } label: {
                  Image(systemName: "arrow.up")
                }
                .buttonStyle(.card)
              }
              if station.buttonNumber < stations.count - 1 {
                Button {
                  moveStation(from: station.buttonNumber,
                              offset:  station.buttonNumber + 2)
                } label: {
                  Image(systemName: "arrow.down")
                }
                .buttonStyle(.card)
              }
            }
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






//import SwiftUI
//import MusicKit
//import Constants
//import Model
//import ApplicationState
//import PlayersTV
//
//struct StationListView {
//  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
//  @ObservedObject  var stationLister: StationLister
//  private var currentStation = CurrentStation.shared.nowPlaying
//  @State private var isShowingAlert: Bool = false
//  @Binding var isShowingFullPlayer: Bool
//}
//
//extension StationListView: View {
//  var body: some View {
//    
//    ForEach(stationLister.stations) {station in
//      HStack {
//        StationBillboard(station: station,
//                         currentStation: currentStation)
//        
//        if currentStation == station {
//          HStack {
//            Button {
//              isShowingAlert = true
//            } label: {
//              Image(systemName: "ellipsis.circle.fill")
//            }
//            .buttonStyle(.card)
//            .alert("\(station.name) Actions", isPresented: $isShowingAlert) {
//              Button("Delete", role: .destructive) {
//                stationLister.deleteStation(station)
//              }
//              Button("Station Playlist") {
//                CurrentActivity.shared.beginStationSongList(for: station)
//              }
//              
//              if !station.isChart && station.availableSongs.count > 24 {
//                Button("Rotate Music") {
//                  do {
//                    try station.rotate()
//                  } catch {
//                    RadioTVLogger.stationMusicRotator.info("Couldn't rotate the music for \(station.stationName)")
//                  }
//                }
//              }
//              if let added = station.stack(for: .added),
//                 let addedSongs = added.songs,
//                 (!station.isChart && addedSongs.count > 4) {
//                Button("Add New Music and Rotate") {
//                  do {
//                    try station.addAndRotate()
//                  }
//                  catch { RadioTVLogger.stationMusicRotator.info("Couldn't add rotate the music for \(station.stationName)")
//                  }
//                }
//              }
//            }
//            VStack {
//              
//              
//              if station.buttonNumber > 0 {
//                Button {
//                  stationLister.moveStation(from: station.buttonNumber,
//                                            offset: station.buttonNumber - 1)
//                } label: {
//                  Image(systemName: "arrow.up")
//                }
//                .buttonStyle(.card)
//              }
//              if station.buttonNumber < stationLister.stations.count - 1 {
//                Button {
//                  stationLister.moveStation(from: station.buttonNumber,
//                                            offset:  station.buttonNumber + 2)
//                } label: {
//                  Image(systemName: "arrow.down")
//                }
//                .buttonStyle(.card)
//              }
//            }
//            if ApplicationMusicPlayer.shared.state.playbackStatus == .playing {
//              StationPauseButton()
//            } else if ApplicationMusicPlayer.shared.state.playbackStatus == .paused {
//              StationPlayButton()
//            }
//            
//              Button {
//                isShowingFullPlayer = true
//
//              } label: {
//                  Image(systemName: "radio.fill")
//
//              }
//              .buttonStyle(.card)
//
//          }
//        }
//      }
//    }
//      .animation(.default, value: stationLister.stations)
//      .onAppear {
//        stationLister.updateStationList()
//      }
//    }
//  }
//
