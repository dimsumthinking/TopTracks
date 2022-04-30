import Foundation
import CoreData


extension TopTracksStation {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStation> {
    return NSFetchRequest<TopTracksStation>(entityName: "TopTracksStation")
  }
  
  @NSManaged public var buttonPosition: Int16
  @NSManaged public var favorite: Bool
  @NSManaged public var stationName: String
  @NSManaged public var stationID: UUID
  @NSManaged public var stacks: Set<TopTracksStack>
  @NSManaged public var clockID: String
  @NSManaged public var lastUpdated: Date
  @NSManaged public var lastPlayed: Date?
  @NSManaged public var chartInfo: TopTracksChartStation?
  @NSManaged public var playlistInfo: TopTracksPlaylistStation?
  @NSManaged public var appleStationInfo: TopTracksStationStation?
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
  var clock: RotationClock? {
    RotationClock(rawValue: clockID)
  }
  var stationIDAsString: String {
    stationID.description
  }
}

extension TopTracksStation {
  var stationType: TopTracksStationType {
    if chartType != nil {
      return .chart
    } else if playlistInfo != nil {
      return .playlist
    } else {
      return .station
    }
  }
  var chartType: TopTracksChartType? {
    TopTracksChartType(rawValue: chartInfo?.chartType ?? "")
  }
  var isGenreChart: Bool {
    guard let stationType = chartType else {
      return false
    }
    return stationType == .topSongs
  }
  var isCityChart: Bool {
    guard let stationType = chartType else {
      return false
    }
    return stationType == .cityCharts
  }
  var isDailyChart: Bool {
    guard let stationType = chartType else {
      return false
    }
    return stationType == .dailyTop100
  }
  var isPlaylistChart: Bool {
    guard let stationType = chartType else {
      return false
    }
    return stationType == .playlists
  }
  
  var topTracksStationSize: TopTracksStationSize {
    let size = stacks
      .filter {stack in
      standardRotationCategories.map(\.rawValue).contains(stack.stackName)
    }
    .map(\.songs.count)
    .reduce(0, +)
    print("Size is: ", size.description)
    return size >= 40 ? .full : .mini
  }
  
  func stack(_ rotationCategory: RotationCategory) -> TopTracksStack? {
    stacks.filter{stack in stack.stackName == rotationCategory.rawValue}.first
  }

}


