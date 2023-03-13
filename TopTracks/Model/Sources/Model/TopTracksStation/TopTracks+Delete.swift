import MusicKit
import CoreData

extension TopTracksStation {
  public static func delete(topTracksStation: TopTracksStation,
                            context: NSManagedObjectContext) {
    context.delete(topTracksStation)
    do {
      try context.save()
      print("tried to save \(topTracksStation.name)")
    } catch {
      context.rollback()
      print("Not able to create a new station\n", error)
    }
  }
}
