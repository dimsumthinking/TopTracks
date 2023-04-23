import MusicKit
import CoreData

extension TopTracksStation {
  public static func delete(topTracksStation: TopTracksStation,
                            context: NSManagedObjectContext) {
    context.delete(topTracksStation)
    topTracksStation.saveIfPossible()

  }
}
