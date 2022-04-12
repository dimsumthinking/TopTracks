import CoreData
import SwiftUI
import MusicKit


class StationList: NSObject, ObservableObject {
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

extension StationList: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    if let updatedStations = fetchedResultsController.fetchedObjects {
      stations = updatedStations
    }
  }
}

extension StationList {
  private func updateStationList() {
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

extension StationList {
  func deleteStation(at index: Int,
                     currentlyPlaying: CurrentlyPlaying) {
//    if stations[index].stationID == StationView.currentStationID {
    if stations[index] == currentlyPlaying.station {
      ApplicationMusicPlayer.shared.pause()
      stationSongPlayer.clearPlayer()
      currentlyPlaying.song = nil
    }
    context.delete(stations[index])
    do {
      try context.save()
    } catch {
      fatalError("Couldn't save after deleting station")
    }
    renumberButtons(using: context)
  }
}

extension StationList {
  func moveStation(at currentPosition: Int,
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
}

extension StationList {
  func renumberButtons(using context: NSManagedObjectContext) {
    for (index, station) in stations.enumerated() {
      station.buttonNumber = index + 1
      do {
        try context.save()
      } catch {
        fatalError("Couldn't renumber button positions")
      }
    }
  }
}
