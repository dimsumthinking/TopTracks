import Foundation
import CoreData
import MusicKit


extension TopTracksStationStation {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStationStation> {
    return NSFetchRequest<TopTracksStationStation>(entityName: "TopTracksStationStation")
  }
  
  @NSManaged public var appleStationID: String
  @NSManaged public var appleStationName: String
  @NSManaged public var stationAsData: Data?
  @NSManaged public var station: TopTracksStation
  
}

extension TopTracksStationStation : Identifiable {
  
}

extension TopTracksStationStation {
  var appleMusicStation: Station? {
    guard let data = stationAsData else {return nil}
    return try? PropertyListDecoder().decode(Station.self, from: data)
  }
}
