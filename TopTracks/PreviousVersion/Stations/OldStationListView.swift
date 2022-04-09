//import SwiftUI
//import MusicKit
//
//struct StationListView {
//  @State private var isShowingSettings = false
//  @State private var isShowingPlayer = false
//  @Environment(\.managedObjectContext) private var viewContext
//  @Environment(\.editMode) private var editMode
//  @EnvironmentObject var topTracksStatus: TopTracksStatus
//  @FetchRequest(entity: TopTracksStation.entity(),
//                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
//                                                   ascending: true)]) var stations: FetchedResults<TopTracksStation>
//  //  @State private var currentStationID: UUID?
//}
//
//extension StationListView: View {
//  var body: some View {
//    //    NavigationView {
//    VStack {
//      listAllStations
//      //        .toolbar {
//      //          ToolbarItem(placement: .navigationBarTrailing) {
//      //            EditButton()
//      //              .disabled(stations.isEmpty)
//      //          }
//      //          ToolbarItem(placement: .navigationBarLeading){
//      //            Button(action: {isShowingSettings = true}){
//      //              Image(systemName: "gear")
//      //            }
//      //          }
//      //        }
////      Button(action: startBuilding){
////        Text("Create a new station")
////          .padding()
////          .padding(.horizontal)
////      }
////      .padding(30)
////      .buttonStyle(.borderedProminent
//      Text("Tap here")
//        .contentShape(Rectangle())
//        .onTapGesture {
//          isShowingPlayer = true
//        }
//    }
////  }
//    .sheet(isPresented: $isShowingSettings){
//      SettingsView(isShowingSettings: $isShowingSettings)
//    }
//    .sheet(isPresented: $isShowingPlayer) {
//      Image(systemName: "arrow.right")
//        .resizable()
//        .scaledToFill()
//    }
//}
//}
//
//
//
//extension StationListView {
//  private var listAllStations: some View {
//    List {
//      ForEach(stations) {station in
//        NavigationLink {
//          StationView(station: station)
//        } label: {
//          StationBillboardView(station: station)
//        }
//      }
//      .onDelete(perform: deleteStation)
//      .onMove(perform: moveStation)
//    }
//    .navigationTitle("Stations")
//    .navigationBarTitleDisplayMode(.inline)
//  }
//}
//
//extension StationListView {
//  private func deleteStation(at indexSet: IndexSet) {
//    guard let first = indexSet.first else {
//      fatalError("Couldn't locate item to delete")
//    }
//    if stations[first].stationID == StationView.currentStationID {
//      ApplicationMusicPlayer.shared.pause()
//    }
//    viewContext.delete(stations[first])
//    do {
//      try viewContext.save()
//    } catch {
//      fatalError("Couldn't save after deleting station")
//    }
//    renumberButtons()
//  }
//  private func moveStation(at indexSet: IndexSet, offset: Int) {
//    guard let first = indexSet.first else {return}
//    if first < offset {
//      stations[first].buttonNumber = offset
//      for (index, station) in stations.enumerated() where index > first && index < offset {
//        station.buttonPosition -= 1
//      }
//    } else {
//      stations[first].buttonNumber = offset + 1
//      for (index, station) in stations.enumerated() where index >= offset && index < first {
//        station.buttonPosition += 1
//      }
//    }
//    do {
//      try viewContext.save()
//    } catch {
//      fatalError("Couldn't renumber button positions")
//    }
//  }
//}
//
//extension StationListView {
//  func renumberButtons() {
//    for (index, station) in stations.enumerated() {
//      station.buttonNumber = index + 1
//      do {
//        try viewContext.save()
//      } catch {
//        fatalError("Couldn't renumber button positions")
//      }
//    }
//  }
//}
//
//extension StationListView {
//  private func startBuilding() {
//    topTracksStatus.isCreatingNew = true
//  }
//}
//
//struct StationListView_Previews: PreviewProvider {
//  static var previews: some View {
//    StationListView()
//  }
//}
