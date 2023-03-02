//
//  TopTracksStation+CoreDataProperties.swift
//  TopTracks
//
//  Created by Daniel Steinberg on 3/2/23.
//
//

import Foundation
import CoreData


extension TopTracksStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStation> {
        return NSFetchRequest<TopTracksStation>(entityName: "TopTracksStation")
    }

    @NSManaged public var buttonPosition: Int16
    @NSManaged public var favorite: Bool
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var playlistID: String?
    @NSManaged public var stationID: UUID?
    @NSManaged public var stationName: String?
    @NSManaged public var updateAvailable: Bool
    @NSManaged public var lastPlayed: Date?
    @NSManaged public var artworkAsData: Data?
    @NSManaged public var allowRecommendations: Bool
    @NSManaged public var playlistAsData: Data?
    @NSManaged public var stacks: NSSet?

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
