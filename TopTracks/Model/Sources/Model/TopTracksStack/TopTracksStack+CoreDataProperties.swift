import Foundation
import CoreData


extension TopTracksStack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStack> {
        return NSFetchRequest<TopTracksStack>(entityName: "TopTracksStack")
    }

    @NSManaged public var name: String
    @NSManaged public var songs: Set<TopTracksSong>
    @NSManaged public var station: TopTracksStation

}

// MARK: Generated accessors for songs
extension TopTracksStack {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: TopTracksSong)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: TopTracksSong)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}

extension TopTracksStack : Identifiable {

}

extension TopTracksStack {
  var rotationCategory: RotationCategory {
    guard let category = RotationCategory(rawValue: name) else {
      fatalError("No Rotation Category corresponds to this stack - which shouldn't be possible")
    }
    return category
  }
  
  var orderedSongs: [TopTracksSong] {
    songs.sorted {$0.lastPlayed < $1.lastPlayed}
  }
}

