import Foundation
import CoreData
import MusicKit


extension TopTracksSong {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksSong> {
    return NSFetchRequest<TopTracksSong>(entityName: "TopTracksSong")
  }
  
  @NSManaged public var songAsData: Data?
  @NSManaged public var songID: String
  @NSManaged public var lastPlayed: Date
  @NSManaged public var rating: String
  @NSManaged public var motion: String
  @NSManaged public var stack: TopTracksStack
  @NSManaged public var title: String
  @NSManaged public var artistName: String
  @NSManaged public var id: UUID


  
}

extension TopTracksSong : Identifiable {
  
}

extension TopTracksSong {
  public var song: Song? {
    guard let data = songAsData else {return nil}
    return try? PropertyListDecoder().decode(Song.self, from: data)
  }
  
  public func markPlayed()  {
    guard let context = managedObjectContext else { return }
    lastPlayed = Date()
    do {
      try context.save()
    }
    catch {
      context.rollback()
      print("Couldn't mark TopTracksSong as played")
    }
  }
  
  public var songRating: SongRating? {
    SongRating(rawValue: rating)
  }
  
  public var station: TopTracksStation {
    stack.station
  }
}
