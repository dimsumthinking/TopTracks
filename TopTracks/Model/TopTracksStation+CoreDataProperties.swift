import Foundation
import CoreData


extension TopTracksStation {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStation> {
    return NSFetchRequest<TopTracksStation>(entityName: "TopTracksStation")
  }
  
  @NSManaged public var buttonPosition: Int16
  @NSManaged public var clockPosition: Int16
  @NSManaged public var favorite: Bool
  @NSManaged public var lastUpdated: Date
  @NSManaged public var updateAvailable: Bool
  @NSManaged public var playlistID: String
  @NSManaged public var stationName: String
  @NSManaged public var stationID: UUID
  @NSManaged public var isPlaying: Bool
  @NSManaged public var currentSong: String?
  @NSManaged public var clock: String
  @NSManaged public var stacks: Set<TopTracksStack>
  
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
  var currentClockPosiition: Int {
    get {
      Int(clockPosition)
    }
    set {
      clockPosition = Int16(newValue)
    }
  }
}
