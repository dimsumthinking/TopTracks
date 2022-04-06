import Foundation
import CoreData


extension TopTracksPlaylistStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksPlaylistStation> {
        return NSFetchRequest<TopTracksPlaylistStation>(entityName: "TopTracksPlaylistStation")
    }

    @NSManaged public var updateAvailable: Bool
    @NSManaged public var playlistName: String?
    @NSManaged public var playlistID: String?
    @NSManaged public var station: TopTracksStation?
    @NSManaged public var archive: Set<TopTracksPlaylistStationArchive>

}

// MARK: Generated accessors for archive
extension TopTracksPlaylistStation {

    @objc(addArchiveObject:)
    @NSManaged public func addToArchive(_ value: TopTracksPlaylistStationArchive)

    @objc(removeArchiveObject:)
    @NSManaged public func removeFromArchive(_ value: TopTracksPlaylistStationArchive)

    @objc(addArchive:)
    @NSManaged public func addToArchive(_ values: NSSet)

    @objc(removeArchive:)
    @NSManaged public func removeFromArchive(_ values: NSSet)

}

extension TopTracksPlaylistStation : Identifiable {

}
