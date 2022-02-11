import SwiftUI

struct StationListView {
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.editMode) private var editMode
  @EnvironmentObject var topTracksStatus: TopTracksStatus
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)]) var stations: FetchedResults<TopTracksStation>
}

extension StationListView: View {
  var body: some View {
    NavigationView {
      if stations.isEmpty {
        OnBoardingIntroView()
      } else {
        listAllStations
          .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
              EditButton()
                .disabled(topTracksStatus.needsAppSubscription)
              Button(action: startBuilding) {
                Image(systemName: "plus")
              }
              .disabled(topTracksStatus.needsAppSubscription)
            }
            ToolbarItem(placement: .navigationBarLeading){
              Button(action: {}){
                Image(systemName: "gear")
              }
            }
          }
      }
    }
  }
}

extension StationListView {
  private var promptToCreateStation: some View {
    Button("Create your first Station",
           action: startBuilding)
  }
  
  private var listAllStations: some View {
    List {
      ForEach(stations, id: \.self) {station in
        NavigationLink {
          StationView(station: station)
        } label: {
          Text(station.stationName)
        }
      }
      .onDelete(perform: deleteStation)
      .onMove(perform: moveStation)
    }
    .navigationTitle("Stations")
  }
}

extension StationListView {
  private func deleteStation(at indexSet: IndexSet) {
    guard let first = indexSet.first else {
      fatalError("Couldn't locate item to delete")
    }
    viewContext.delete(stations[first])
    do {
      try viewContext.save()
    } catch {
      fatalError("Couldn't save after deleting station")
    }
    renumberButtons()
  }
  private func moveStation(at indexSet: IndexSet, offset: Int) {
    guard let first = indexSet.first else {return}
    if first < offset {
      stations[first].buttonNumber = offset
      for (index, station) in stations.enumerated() where index > first && index < offset {
        station.buttonPosition -= 1
      }
    } else {
      stations[first].buttonNumber = offset + 1
      for (index, station) in stations.enumerated() where index >= offset && index < first {
        station.buttonPosition += 1
      }
    }
    do {
      try viewContext.save()
    } catch {
      fatalError("Couldn't renumber button positions")
    }
  }
}

extension StationListView {
  func renumberButtons() {
    for (index, station) in stations.enumerated() {
      station.buttonNumber = index + 1
      do {
        try viewContext.save()
      } catch {
        fatalError("Couldn't renumber button positions")
      }
    }
  }
}

extension StationListView {
  private func startBuilding() {
    topTracksStatus.isCreatingNew = true
  }
}

struct StationListView_Previews: PreviewProvider {
  static var previews: some View {
    StationListView()
  }
}
