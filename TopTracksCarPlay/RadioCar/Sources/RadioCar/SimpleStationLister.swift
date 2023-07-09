import CoreData
import MusicKit
import Model



class SimpleStationLister: NSObject {
  @Published private(set) var stations: [TopTracksStation] = []
  private let fetchedResultsController: NSFetchedResultsController<TopTracksStation>
  private let context = sharedViewContext
  
  override init() {
    let request = TopTracksStation.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "buttonPosition",
                                                ascending: true)]
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

extension SimpleStationLister {
  func updateStationList() {
    do {
      try fetchedResultsController.performFetch()
      if let updatedStations = fetchedResultsController.fetchedObjects {
        //          normalizeButtonOrder(for: updatedStations)
        stations = updatedStations
      }
    }
    catch {
      print("Couldn't update station list:", error)
    }
  }
}

extension SimpleStationLister: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    if let updatedStations = fetchedResultsController.fetchedObjects {
      stations = updatedStations
    }
  }
}

//extension StationLister {
//  func updateStationList() {
//    do {
//      try fetchedResultsController.performFetch()
//      if let updatedStations = fetchedResultsController.fetchedObjects {
//        normalizeButtonOrder(for: updatedStations)
////        stations = updatedStations
//      }
//    }
//    catch {
//      print("Couldn't update station list:", error)
//    }
//  }
//
//  private func normalizeButtonOrder(for orderedStations: [TopTracksStation]) {
//    for (index, station) in orderedStations.enumerated() {
//      station.buttonNumber = index
//    }
//    do {
//      try context.save()
//    } catch {
//      context.rollback()
//
//    }
//    stations = orderedStations
//  }
//}
//
//
//}

