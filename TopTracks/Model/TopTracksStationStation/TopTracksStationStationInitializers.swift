
import CoreData
import MusicKit

extension TopTracksStationStation {
  convenience init(appleMusicStation: Station,
                   station: TopTracksStation,
                   context: NSManagedObjectContext = sharedViewContext) {
    self.init(context: context)
    self.station = station
    self.appleStationID = appleMusicStation.id.rawValue
    self.appleStationName = appleMusicStation.name
    self.stationAsData = try? PropertyListEncoder().encode(appleMusicStation)
  }
}

