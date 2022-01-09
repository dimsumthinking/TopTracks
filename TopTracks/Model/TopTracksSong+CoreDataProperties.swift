import Foundation
import CoreData


extension TopTracksSong {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksSong> {
        return NSFetchRequest<TopTracksSong>(entityName: "TopTracksSong")
    }

    @NSManaged public var artistName: String
    @NSManaged public var id: String
    @NSManaged public var stackPosition: Int16
    @NSManaged public var title: String
    @NSManaged public var stack: TopTracksStack

}

extension TopTracksSong : Identifiable {

}
extension TopTracksSong {
  var currentStackPosition: Int {
    get {
      Int(stackPosition)
    }
    set {
      stackPosition = Int16(newValue)
    }
  }
}
