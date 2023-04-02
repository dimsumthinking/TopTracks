import CoreData
import SwiftUI
import MusicKit
import Model
import ApplicationState
import Foundation


class StationLister: NSObject, ObservableObject {
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
    CurrentQueue.shared.stopPlayingDeletedStation(station)
    TopTracksStation.delete(topTracksStation: station,
                            context: context)
  }
  
  
  func moveStation(from currentPosition: Int,
                   offset: Int) {
    if currentPosition < offset {
      stations[currentPosition].buttonNumber = offset
      for (index, station) in stations.enumerated() where index > currentPosition && index < offset {
        station.buttonPosition -= 1
      }
    } else {
      stations[currentPosition].buttonNumber = offset + 1
      for (index, station) in stations.enumerated() where index >= offset && index < currentPosition {
        station.buttonPosition += 1
      }
    }
    do {
      try context.save()
    } catch {
      fatalError("Couldn't renumber button positions")
    }
  }
  
  func moveToTop(_ station: TopTracksStation) {
    if let currentPosition = stations.firstIndex(of: station) {
      moveStation(from: currentPosition,
                  offset: 0)
    } 
  }
  
}


