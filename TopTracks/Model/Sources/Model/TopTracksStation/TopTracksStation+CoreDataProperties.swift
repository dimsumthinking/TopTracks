import Foundation
import CoreData
import MusicKit


extension TopTracksStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStation> {
        return NSFetchRequest<TopTracksStation>(entityName: "TopTracksStation")
    }
  @NSManaged public var favorite: Bool
  @NSManaged public var buttonPosition: Int16
  @NSManaged public var stationLastUpdated: Date
  @NSManaged public var stacksLastRotated: Date
  @NSManaged public var playlistLastUpdated: Date?
  @NSManaged public var playlistID: String
  @NSManaged public var stationID: UUID
  @NSManaged public var stationName: String
  @NSManaged public var updateAvailable: Bool
  @NSManaged public var lastTouched: Date
  @NSManaged public var allowRecommendations: Bool
  @NSManaged public var playlistAsData: Data?
  @NSManaged public var stacks: Set<TopTracksStack>
  @NSManaged public var isChart: Bool


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
  public var name: String {
    stationName
  }
  
  public var playlist: Playlist? {
    guard let playlistAsData,
          let playlist = try? PropertyListDecoder().decode(Playlist.self, from: playlistAsData) else {return nil}
    return playlist
  }
  
  public var artwork: Artwork? {
//    guard let playlistAsData,
//          let playlist = try? PropertyListDecoder().decode(Playlist.self, from: playlistAsData) else {return nil}
    return playlist?.artwork
  }
  
  public var topArtists: String {
    String(stacks.filter{ stack in stack.name == "power"}.flatMap(\.songs).map(\.title)
      .reduce("") {$1 + ", " + $0}.dropLast(2))
  }
  
  public var buttonNumber: Int {
    get {
      Int(buttonPosition)
    }
    set {
      buttonPosition = Int16(newValue)
    }
  }
  
  public func stack(for rotationCategory: RotationCategory) -> TopTracksStack? {
    stacks.first(where: { $0.name == rotationCategory.name})
  }
  
  public var hasEnoughGold: Bool {
    (stack(for: .gold)?.songs.count ?? 0) > 10
  }
  
  public var hasEnoughGoldForTwoAnHour: Bool {
    (stack(for: .gold)?.songs.count ?? 0) > 24
  }
  
  public var allSongs: [TopTracksSong] {
    self.stacks.flatMap(\.songs)
  }
  
  public var activeSongs: [TopTracksSong] {
    allSongs.filter{song in stationStandardCategories.contains(song.stack.rotationCategory)}
  }
  
  public var availableSongs: [TopTracksSong] {
    allSongs.filter{song in stationExtendedCategories.contains(song.stack.rotationCategory)}
  }
}

extension TopTracksStation {
  public func changeStack(for topTracksSong: TopTracksSong,
            to category: RotationCategory) {
    let startingStack = topTracksSong.stack
    guard startingStack.name != category.rawValue else { return }
    if let destinationStack = stacks.filter({ stack in stack.name == category.name}).first {
      destinationStack.addToSongs(topTracksSong)
      topTracksSong.stack = destinationStack
      startingStack.removeFromSongs(topTracksSong)
    }
  }
  
  public func changeStack(for topTrackSongs: [TopTracksSong],
                   to category: RotationCategory) {
    for song in topTrackSongs {
      changeStack(for: song,
                  to: category)
    }
  }
  
  
  public func changeStationName(to stationName: String) {
    self.stationName = stationName
//    guard let managedObjectContext else {return}
    saveIfPossible()
//    do {
//      try managedObjectContext.save()
//    } catch {
//      managedObjectContext.rollback()
//      print("Couldn't change station name")
//    }
  }
  
  
}

extension TopTracksStation {
  public func remove(song: Song) {
    guard let topTracksSong = allSongs.first(where:{ topTracksSong in topTracksSong.songID == song.id.rawValue}) else { return }
    changeStack(for: topTracksSong, to: .removed)
    if let added =  stack(for: .added)?.songs.first {
      changeStack(for: added, to: topTracksSong.stack.rotationCategory)
    } else if let gold = stack(for: .gold)?.songs.first {
      changeStack(for: gold, to: topTracksSong.stack.rotationCategory)
    } else if let archived = stack(for: .archived)?.songs.first {
      changeStack(for: archived, to: topTracksSong.stack.rotationCategory)
    }
    saveIfPossible()
  }
}
