import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import StationUpdaters
import SwiftData

struct StationListView {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
//  @ObservedObject  var stationLister: StationLister
  @State private var currentStation: TopTracksStation?
  @Query(sort: \.buttonPosition, order: .forward, animation: .bouncy) var stations: [TopTracksStation]
}

extension StationListView: View {
  var body: some View {
    List {
      ForEach(stations) {station in
        StationBillboard(station: station,
                         currentStation: currentStation)
        .listRowInsets(EdgeInsets(top: 20, leading: 6, bottom: 20, trailing: 6))
        .swipeActions(allowsFullSwipe: true) {
          
          Button(role: .destructive) {
            fatalError("missing station delete")
            //          stationLister.deleteStation(station)
          }  label: {
            Image(systemName: "trash.fill")
          }
          if stations.count > 1 {
            Button {
              fatalError("Missing move to top")
              //            stationLister.moveToTop(station)
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
        fatalError("missing delete station")
//        stationLister.deleteStation( stationLister.stations[index])
      }
    }
    .onMove { indexSet, offset in
      if let fromLocation = indexSet.first {
        fatalError("missing move station")
        //        stationLister.moveStation(from: fromLocation,
        //                                  offset: offset)
      }
    }
    }
    
    .animation(.default, value: stations)
    .onAppear {
//      stationLister.updateStationList()
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
//if stationLister.stations.isEmpty {
//          Button {
//            CurrentActivity.shared.beginCreating()
//          } label: {
//            HStack {
//              Text("Tap")
//              Image(systemName: "plus")
//              Text("to create a station")
//              Image(systemName: "arrow.up.right")
//            }
//            .font(.headline)
//            .foregroundColor(.yellow)
//
//          }
//
//        }
//  Rectangle()
//    .frame(height: Constants.miniPlayerArtworkImageSize * 3 / 2)
//    .foregroundColor(.clear)
//    .listRowSeparatorTint(.clear)
//      .listStyle(.plain)

