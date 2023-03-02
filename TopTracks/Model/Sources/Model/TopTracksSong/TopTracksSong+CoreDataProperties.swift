//
//  TopTracksSong+CoreDataProperties.swift
//  TopTracks
//
//  Created by Daniel Steinberg on 3/2/23.
//
//

import Foundation
import CoreData


extension TopTracksSong {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksSong> {
        return NSFetchRequest<TopTracksSong>(entityName: "TopTracksSong")
    }

    @NSManaged public var songAsData: Data?
    @NSManaged public var songID: String?
    @NSManaged public var lastPlayed: Date?
    @NSManaged public var favorite: Bool
    @NSManaged public var stack: TopTracksStack?

}

extension TopTracksSong : Identifiable {

}
