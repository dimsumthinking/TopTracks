import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import StationUpdaters
import PlayersTV

struct StationListView {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @ObservedObject  var stationLister: StationLister
  @State private var currentStation: TopTracksStation?
  @State private var isShowingAlert: Bool = false
}

extension StationListView: View {
  var body: some View {
    
    ForEach(stationLister.stations) {station in
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
                stationLister.deleteStation(station)
              }
              Button("Station Playlist") {
                CurrentActivity.shared.beginStationgSongList(for: station)
              }
              
              if !station.isChart && station.availableSongs.count > 24 {
                Button("Rotate Music") {
                  let rotator = RotateExistingMusic(in: station)
                  rotator.rotate()
                }
              }
              if let added = station.stack(for: .added),
                 (!station.isChart && added.songs.count > 4) {
                Button("Add New Music and Rotate") {
                  let adder = AddAndRotateMusic(in: station)
                  adder.add()
                }
              }
            }
            VStack {
              
              
              if station.buttonNumber > 0 {
                Button {
                  stationLister.moveStation(from: station.buttonNumber,
                                            offset: station.buttonNumber - 1)
                } label: {
                  Image(systemName: "arrow.up")
                }
                .buttonStyle(.card)
              }
              if station.buttonNumber < stationLister.stations.count - 1 {
                Button {
                  stationLister.moveStation(from: station.buttonNumber,
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
                CurrentActivity.shared.beginImporting()

              } label: {

                  Image(systemName: "radio.fill")
              }
              .buttonStyle(.card)
//            .navigationDestination(for: Bool.self) {_ in
//              MainPlayerView()
//            }
          }
        }
      }
    }
      .animation(.default, value: stationLister.stations)
      .onAppear {
        stationLister.updateStationList()
        currentStation = CurrentStation.shared.topTracksStation
      }
      .task {
        await subscribeToCurrentStation()
      }
      
      
    }
  }
  
  extension StationListView {
    private func subscribeToCurrentStation() async {
      do {
        let stations = try CurrentStation.shared.currentStationStream()
        for await station in stations {
          self.currentStation = station
        }
      } catch {
        print(error)
      }
    }
  }
  //ShowStacksButton(station: station)
  //if !station.isChart && station.availableSongs.count > 24 {
  //  RotateMusicButton(station: station)
  //}
  //if let added = station.stack(for: .added),
  //   (!station.isChart && added.songs.count > 4) {
  //  AddAndRotateMusicButton(station: station)
  //}
