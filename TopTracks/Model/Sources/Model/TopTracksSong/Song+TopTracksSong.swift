import MusicKit
import CoreData
import Foundation

extension Song {
  public var anyMatchingTopTracksSong: TopTracksSong? {
    let request = TopTracksSong.fetchRequest()
    request.predicate = NSPredicate(format: "songID == %@", id.rawValue)
    let context = PersistenceController.newBackgroundContext
    do {
      let matchingSongs = try context.fetch(request)
      matchingSongs.forEach {matchingSong in matchingSong.markPlayed()}
      return matchingSongs.first
    } catch {
      print("Failed to find TopTracksSong from Song")
      return nil
    }
  }
  
  public var storedArtwork: Artwork? {
    anyMatchingTopTracksSong?.song?.artwork
  }
}
