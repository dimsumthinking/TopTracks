//
//  TopTracksSongArchive+CoreDataProperties.swift
//  TopTracks
//
//  Created by Daniel Steinberg on 4/4/22.
//
//

import Foundation
import CoreData


extension TopTracksSongArchive {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksSongArchive> {
        return NSFetchRequest<TopTracksSongArchive>(entityName: "TopTracksSongArchive")
    }

    @NSManaged public var songID: String?
    @NSManaged public var stack: String?
    @NSManaged public var archive: TopTracksPlaylistStationArchive?

}

extension TopTracksSongArchive : Identifiable {

}
