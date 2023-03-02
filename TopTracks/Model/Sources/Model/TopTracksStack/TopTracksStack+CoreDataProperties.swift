//
//  TopTracksStack+CoreDataProperties.swift
//  TopTracks
//
//  Created by Daniel Steinberg on 3/2/23.
//
//

import Foundation
import CoreData


extension TopTracksStack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStack> {
        return NSFetchRequest<TopTracksStack>(entityName: "TopTracksStack")
    }

    @NSManaged public var name: String?
    @NSManaged public var songs: NSSet?
    @NSManaged public var station: TopTracksStation?

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
