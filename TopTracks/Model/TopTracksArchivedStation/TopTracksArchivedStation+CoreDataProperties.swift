import Foundation
import CoreData


extension TopTracksArchivedStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksArchivedStation> {
        return NSFetchRequest<TopTracksArchivedStation>(entityName: "TopTracksArchivedStation")
    }

    @NSManaged public var archiveDate: Date?
    @NSManaged public var stacks: Set<TopTracksStack>
    @NSManaged public var station: TopTracksStation

}

// MARK: Generated accessors for stacks
extension TopTracksArchivedStation {

    @objc(addStacksObject:)
    @NSManaged public func addToStacks(_ value: TopTracksStack)

    @objc(removeStacksObject:)
    @NSManaged public func removeFromStacks(_ value: TopTracksStack)

    @objc(addStacks:)
    @NSManaged public func addToStacks(_ values: NSSet)

    @objc(removeStacks:)
    @NSManaged public func removeFromStacks(_ values: NSSet)

}

extension TopTracksArchivedStation : Identifiable {

}
