import Foundation
import CoreData


extension TopTracksClock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksClock> {
        return NSFetchRequest<TopTracksClock>(entityName: "TopTracksClock")
    }

    @NSManaged public var clockAsData: Data?
    @NSManaged public var clockPosition: Int16
    @NSManaged public var station: TopTracksStation

}

extension TopTracksClock : Identifiable {

}

extension TopTracksClock {
  var currentClockPosition: Int {
    get {
      Int(clockPosition)
    }
    set {
      clockPosition = Int16(newValue)
    }
  }
  
  var currentClock: RotationClock? {
    guard let data = clockAsData else {return nil}
    return try? PropertyListDecoder().decode(RotationClock.self, from: data)
  }
  
  
}
