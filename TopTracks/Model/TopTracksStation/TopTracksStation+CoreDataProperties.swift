import Foundation
import CoreData


extension TopTracksStation {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStation> {
    return NSFetchRequest<TopTracksStation>(entityName: "TopTracksStation")
  }
  
  @NSManaged public var buttonPosition: Int16
  @NSManaged public var favorite: Bool
  @NSManaged public var updateAvailable: Bool
  @NSManaged public var stationName: String
  @NSManaged public var stationID: UUID
  @NSManaged public var stacks: Set<TopTracksStack>
  @NSManaged public var snapshots: Set<TopTracksArchivedStation>
  @NSManaged public var clockID: String
  @NSManaged public var playlistID: String
  @NSManaged public var lastUpdated: Date
}

// MARK: Generated accessors for stacks
extension TopTracksStation {
  
  @objc(addStacksObject:)
  @NSManaged public func addToStacks(_ value: TopTracksStack)
  
  @objc(removeStacksObject:)
  @NSManaged public func removeFromStacks(_ value: TopTracksStack)
  
  @objc(addStacks:)
  @NSManaged public func addToStacks(_ values: NSSet)
  
  @objc(removeStacks:)
  @NSManaged public func removeFromStacks(_ values: NSSet)
  
  @objc(addSnapshotsObject:)
  @NSManaged public func addToSnapshots(_ value: TopTracksStack)
  
  @objc(removeSnapshotsObject:)
  @NSManaged public func removeFromSnapshots(_ value: TopTracksStack)
  
  @objc(addSnapshots:)
  @NSManaged public func addToSnapshots(_ values: NSSet)
  
  @objc(removeSnapshots:)
  @NSManaged public func removeFromSnapshots(_ values: NSSet)
  
}

extension TopTracksStation : Identifiable {
  
}

extension TopTracksStation {
  var buttonNumber: Int {
    get {
      Int(buttonPosition)
    }
    set {
      buttonPosition = Int16(newValue)
    }
  }
  var clock: RotationClock {
    RotationClock(rawValue: clockID) ?? .standardHour
  }
}
