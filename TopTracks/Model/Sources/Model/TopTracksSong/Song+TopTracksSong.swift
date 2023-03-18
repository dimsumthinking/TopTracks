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
  
  public var everyMatchingTopTracksSong: [TopTracksSong] {
    let request = TopTracksSong.fetchRequest()
    request.predicate = NSPredicate(format: "songID == %@", id.rawValue)
    let context = PersistenceController.newBackgroundContext
    do {
      return try context.fetch(request)
    } catch {
      print("Failed to find TopTracksSong from Song")
      return [TopTracksSong]()
    }
  }
  
  public func moveEveryMatchingTopTracksSong(to category: RotationCategory) {
    let matchingSongs = everyMatchingTopTracksSong
    guard let context = matchingSongs.first?.managedObjectContext else {return}
    matchingSongs.forEach { topTracksSong in
      topTracksSong.station.changeStack(for: topTracksSong,
                                        to: category)
    }
    do {
      try context.save()
    } catch {
      context.rollback()
      print("Couldn't change stack for song", self.title)
    }
  }
  
  public func changeRatingForEveryMatchingTopTracksSong(to rating: SongRating) {
    let matchingSongs = everyMatchingTopTracksSong
    guard let context = matchingSongs.first?.managedObjectContext else {return}
    matchingSongs.forEach { topTracksSong in
      topTracksSong.rating = rating.rawValue
    }
    do {
      try context.save()
    } catch {
      context.rollback()
      print("Couldn't change rating for song", self.title)
    }
  }
  
//  public func matchingTopTracksSong(in station: TopTracksStation) {
//
//  }
  
  public var storedArtwork: Artwork? {
    anyMatchingTopTracksSong?.song?.artwork
  }
}
