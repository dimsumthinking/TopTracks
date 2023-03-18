import Foundation
import CoreData
import MusicKit


extension TopTracksStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksStation> {
        return NSFetchRequest<TopTracksStation>(entityName: "TopTracksStation")
    }
  @NSManaged public var favorite: Bool
  @NSManaged public var lastUpdated: Date
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
  
  public var artwork: Artwork? {
    guard let playlistAsData,
          let playlist = try? PropertyListDecoder().decode(Playlist.self, from: playlistAsData) else {return nil}
    return playlist.artwork
  }
  
  public var topArtists: String {
    String(stacks.filter{ stack in stack.name == "power"}.flatMap(\.songs).map(\.title)
      .reduce("") {$1 + ", " + $0}.dropLast(2))
  }
  
  public func stack(for rotationCategory: RotationCategory) -> TopTracksStack? {
    stacks.first(where: { $0.name == rotationCategory.name})
  }
  
  public var hasEnoughGold: Bool {
    (stack(for: .gold)?.songs.count ?? 0) > 10
  }
  
  public var allSongs: [TopTracksSong] {
    self.stacks.flatMap(\.songs)
  }
  
  public var activeSongs: [TopTracksSong] {
    allSongs.filter{song in stationCreationCategories.contains(song.stack.rotationCategory)}
  }
}

extension TopTracksStation {
  func changeStack(for topTracksSong: TopTracksSong,
            to category: RotationCategory) {
    let startingStack = topTracksSong.stack
    if let destinationStack = stacks.filter({ stack in stack.name == category.name}).first {
      destinationStack.addToSongs(topTracksSong)
      topTracksSong.stack = destinationStack
      startingStack.removeFromSongs(topTracksSong)
    }
  }
  
  public func changeStationName(to stationName: String) {
    self.stationName = stationName
    guard let managedObjectContext else {return}
    do {
      try managedObjectContext.save()
    } catch {
      managedObjectContext.rollback()
      print("Couldn't change station name")
    }
  }
}
