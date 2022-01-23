import Foundation
import CoreData
import MusicKit


extension TopTracksSourcePlaylist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopTracksSourcePlaylist> {
        return NSFetchRequest<TopTracksSourcePlaylist>(entityName: "TopTracksSourcePlaylist")
    }

    @NSManaged public var playlistAsData: Data?
    @NSManaged public var lastUpdated: Date
    @NSManaged public var station: TopTracksStation

}

extension TopTracksSourcePlaylist : Identifiable {

}

extension TopTracksSourcePlaylist {
  var playlist: Playlist? {
    guard let data = playlistAsData else {return nil}
    return try? PropertyListDecoder().decode(Playlist.self, from: data)
  }
}

