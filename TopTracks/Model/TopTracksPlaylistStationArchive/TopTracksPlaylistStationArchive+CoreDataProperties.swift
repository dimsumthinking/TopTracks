//
//  TopTracksPlaylistStationArchive+CoreDataProperties.swift
//  TopTracks
//
//  Created by Daniel Steinberg on 4/4/22.
//
//

import Foundation
import CoreData


extension TopTracksPlaylistStationArchive {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksPlaylistStationArchive> {
        return NSFetchRequest<TopTracksPlaylistStationArchive>(entityName: "TopTracksPlaylistStationArchive")
    }

    @NSManaged public var dateArchived: Date?
    @NSManaged public var archivedSongs: NSSet?
    @NSManaged public var playlistStation: TopTracksPlaylistStation?

}

// MARK: Generated accessors for archivedSongs
extension TopTracksPlaylistStationArchive {

    @objc(addArchivedSongsObject:)
    @NSManaged public func addToArchivedSongs(_ value: TopTracksSongArchive)

    @objc(removeArchivedSongsObject:)
    @NSManaged public func removeFromArchivedSongs(_ value: TopTracksSongArchive)

    @objc(addArchivedSongs:)
    @NSManaged public func addToArchivedSongs(_ values: NSSet)

    @objc(removeArchivedSongs:)
    @NSManaged public func removeFromArchivedSongs(_ values: NSSet)

}

extension TopTracksPlaylistStationArchive : Identifiable {

}
