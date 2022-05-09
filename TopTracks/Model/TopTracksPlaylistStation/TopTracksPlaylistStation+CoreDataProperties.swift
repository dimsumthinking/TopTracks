import Foundation
import CoreData
import MusicKit


extension TopTracksPlaylistStation {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksPlaylistStation> {
    return NSFetchRequest<TopTracksPlaylistStation>(entityName: "TopTracksPlaylistStation")
  }
  
  @NSManaged public var lastUpdated: Date
  @NSManaged public var playlistName: String
  @NSManaged public var playlistID: String
  @NSManaged public var artworkAsData: Data?
  @NSManaged public var station: TopTracksStation
  
}



extension TopTracksPlaylistStation : Identifiable {
  var artwork: Artwork? {
    guard let data = artworkAsData else {return nil}
    return try? PropertyListDecoder().decode(Artwork.self, from: data)
  }
}




