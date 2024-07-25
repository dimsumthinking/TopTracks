import SwiftData
import Foundation


@ModelActor public actor CurrentStationUpdater {}

extension CurrentStationUpdater {
  public init() {
    self.init(modelContainer: CommonContainer.shared.container)
  }
}

extension CurrentStationUpdater {
  public func markPlayed(stationWithID: PersistentIdentifier) {
    if let station = self[stationWithID, as: TopTracksStation.self] {
      station.lastTouched = Date()
      do {
        try modelContext.save()
        StationUpdatersLogger.markingStationAsPlayed.info("Marked station as played: \(station.name)")
      } catch {
        StationUpdatersLogger.markingStationAsPlayed.error("Error marking station as played: \(error)")
      }
    }
  }
}



