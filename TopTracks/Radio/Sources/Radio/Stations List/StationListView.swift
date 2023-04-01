import SwiftUI
import MusicKit
import Constants
import Model
import ApplicationState
import StationUpdaters

struct StationListView {
  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
  @ObservedObject  var stationLister: StationLister
  @EnvironmentObject private var applicationState: ApplicationState
  @State private var currentStation: TopTracksStation?
}

extension StationListView: View {
  var body: some View {
    
    ForEach(stationLister.stations) {station in
      StationBillboard(station: station,
      currentStation: currentStation)
        .listRowInsets(EdgeInsets(top: 20, leading: 6, bottom: 20, trailing: 6))
        .swipeActions {
          Button(role: .destructive) {
            stationLister.deleteStation(station)
          }  label: {
            Image(systemName: "trash.fill")
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


//import SwiftUI
//import MusicKit
//import Constants
//import Model
//import ApplicationState
//import StationUpdaters
//
//public struct StationListView {
//  @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state
//  @StateObject private var stationLister = StationLister()
//  @EnvironmentObject private var applicationState: ApplicationState
//  public init() {}
//}
//
//extension StationListView: View {
//  public var body: some View {
//    NavigationStack {
//      List {
//        ForEach(stationLister.stations) {station in
//          StationBillboard(station: station)
//            .listRowInsets(EdgeInsets(top: 20, leading: 6, bottom: 20, trailing: 6))
//            .swipeActions {
//              Button(role: .destructive) {
//                stationLister.deleteStation(station)
//              }  label: {
//                Image(systemName: "trash.fill")
//              }
//            }
//
//        }
//        .onDelete { indexSet in
//          if let index = indexSet.first {
//            stationLister.deleteStation( stationLister.stations[index])
//          }
//        }
//        .onMove { indexSet, offset in
//          if let fromLocation = indexSet.first {
//            stationLister.moveStation(from: fromLocation,
//                                      offset: offset)
//          }
//        }
//        if stationLister.stations.isEmpty {
//          HStack {
//            Text("Tap")
//            Image(systemName: "plus")
//            Text("to create a station")
//            Image(systemName: "arrow.up.right")
//          }
//          .font(.headline)
//          .foregroundColor(.yellow)
//        }
//        Rectangle()
//          .frame(height: Constants.miniPlayerArtworkImageSize * 3 / 2)
//          .foregroundColor(.clear)
//      }
//      .navigationTitle("Stations")
//      .toolbar {
//        ToolbarItem(placement: .navigationBarTrailing) {
//          Button {
//            ApplicationState.shared.beginCreating()
//          } label: {
//            Image(systemName: "plus")
//          }
//        }
//        ToolbarItem(placement: .navigationBarLeading) {
//          EditButton()
//        }
//      }
//      .animation(.default, value: stationLister.stations)
//      .onAppear {
//        stationLister.updateStationList()
//      }
//      .listStyle(.plain)
//    }
//  }
//}
