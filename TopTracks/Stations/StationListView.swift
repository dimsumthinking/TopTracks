import SwiftUI

struct StationListView {
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.editMode) private var editMode
  @EnvironmentObject var stationConstructionStatus: StationContructionStatus
  @FetchRequest(entity: TopTracksStation.entity(),
                sortDescriptors: [NSSortDescriptor(key: "buttonPosition",
                                                   ascending: true)]) var stations: FetchedResults<TopTracksStation>
}

extension StationListView: View {
  var body: some View {
    NavigationView {
      if stations.isEmpty {
        promptToCreateStation
      } else {
        listAllStations
          .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
              EditButton()
              Button(action: startBuilding) {
                Image(systemName: "plus")
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
        Text(station.stationName)
          .onTapGesture {
            for stack in station.stacks {
                print(stack.stackName)
                for song in stack.songs {
                    print("\t", song.title)
              }
            }
          }
        }
      .onDelete {indexSet in
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
      .onMove {indexSet, offset in
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
    .navigationTitle("Stations")
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
    stationConstructionStatus.isCreatingNew = true
  }
}

struct StationListView_Previews: PreviewProvider {
  static var previews: some View {
    StationListView()
  }
}
