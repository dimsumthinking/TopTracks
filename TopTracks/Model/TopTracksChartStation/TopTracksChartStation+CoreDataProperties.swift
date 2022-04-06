//
//  TopTracksChartStation+CoreDataProperties.swift
//  TopTracks
//
//  Created by Daniel Steinberg on 4/4/22.
//
//

import Foundation
import CoreData


extension TopTracksChartStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksChartStation> {
        return NSFetchRequest<TopTracksChartStation>(entityName: "TopTracksChartStation")
    }

    @NSManaged public var chartType: String
    @NSManaged public var sourceID: String
    @NSManaged public var sourceName: String
    @NSManaged public var station: TopTracksStation

}

extension TopTracksChartStation : Identifiable {

}
