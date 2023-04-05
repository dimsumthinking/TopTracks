import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import StationUpdaters

struct StationListView {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @ObservedObject  var stationLister: StationLister
  @State private var currentStation: TopTracksStation?
}

extension StationListView: View {
  var body: some View {
    
    ForEach(stationLister.stations) {station in
      StationBillboard(station: station,
                       currentStation: currentStation)
      .listRowInsets(EdgeInsets(top: 20, leading: 6, bottom: 20, trailing: 6))
      .swipeActions(allowsFullSwipe: true) {
        
        Button(role: .destructive) {
          stationLister.deleteStation(station)
        }  label: {
          Image(systemName: "trash.fill")
        }
        if stationLister.stations.count > 1 {
          Button {
            stationLister.moveToTop(station)
          } label: {
            Image(systemName: "text.line.first.and.arrowtriangle.forward")
          }
          .tint(.indigo)
        }
        if let url = URL(string: "toptracks://playlist?id=\(station.playlistID)") {
          ShareLink("",
                    item: url,
                    subject: Text("Top Tracks Station \(station.playlist?.name ?? station.stationName)"),
                    message: Text("\n Add \(station.playlist?.name ?? station.stationName) to your TopTracks Stations"),
                    preview: SharePreview("\(station.playlist?.name ?? station.stationName)",
                                          image: Image("AppIcon")))
          .tint(.blue)
        }
      }
      
    }
    .onDelete { indexSet in
      if let index = indexSet.first {
        stationLister.deleteStation( stationLister.stations[index])
      }
    }
    .onMove { indexSet, offset in
      if let fromLocation = indexSet.first {
        stationLister.moveStation(from: fromLocation,
                                  offset: offset)
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
