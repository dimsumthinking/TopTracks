import MusicKit
import CoreData

struct ArtworkRetrieverFromStore {
  static func artwork(for song: Song) -> Artwork? {
    let request = TopTracksSong.fetchRequest()
    request.predicate = NSPredicate(format: "%K == %@", #keyPath(TopTracksSong.songID), song.id.rawValue)
    return try? sharedViewContext.fetch(request).first?.artwork
  }
}
