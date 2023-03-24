import CoreData
import SwiftUI
import MusicKit
import Model
import ApplicationState


class StationLister: NSObject, ObservableObject {
  @Published private(set) var stations: [TopTracksStation] = []
  private let fetchedResultsController: NSFetchedResultsController<TopTracksStation>
  private let context = sharedViewContext

  override init() {
    let request = TopTracksStation.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "lastTouched",
                                                ascending: false)]
    fetchedResultsController
    = NSFetchedResultsController(fetchRequest: request,
                                 managedObjectContext: context,
                                 sectionNameKeyPath: nil,
                                 cacheName: nil)
    super.init()
    fetchedResultsController.delegate = self
    updateStationList()
  }
  
}

extension StationLister: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    if let updatedStations = fetchedResultsController.fetchedObjects {
      stations = updatedStations
    }
  }
}

extension StationLister {
   func updateStationList() {
    do {
      try fetchedResultsController.performFetch()
      if let updatedStations = fetchedResultsController.fetchedObjects {
        stations = updatedStations
      }
    }
    catch {
      print("Couldn't update station list:", error)
    }
  }
}

extension StationLister {
  func deleteStation(_ station: TopTracksStation) {
    TopTracksStation.delete(topTracksStation: station,
                            context: context)
    ApplicationState.shared.noStationSelected()
  }

}

